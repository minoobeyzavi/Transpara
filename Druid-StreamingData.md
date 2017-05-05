## Load Streaming Data to Druid on Linux :: Query with Postman on Windows

Notes: If you haven't already installed Druid, the following specifically installs Druid 0.10.0 (the latest version as of April 2017), rather than using the latest version link in Druid's Quickstart. Please make sure to have installed Oracle JDK 8 and not OpenJDK 8.

#### Install Druid

```
curl -O http://static.druid.io/artifacts/releases/druid-0.10.0-bin.tar.gz
tar -xzf druid-0.10.0-bin.tar.gz
cd druid-*
```

#### Start Zookeeper

```
curl http://www.gtlib.gatech.edu/pub/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz -o zookeeper-3.4.6.tar.gz
tar -xzf zookeeper-3.4.6.tar.gz
cd zookeeper-3.4.6
cp conf/zoo_sample.cfg conf/zoo.cfg
./bin/zkServer.sh start
```

To check Zookeeper is running:

```
echo stat | nc localhost 2181 | grep Mode
```
You should see: "Mode: standalone".

Return to druid-0.10.0 directory and set up the log directory by issuing the command:

```
bin/init
```

[//]: # (Note: You only need to start Zookeeper once in the Linux server and it will always be avaiable.)

#### Start Druid

To use Druid's services, they should always be up and running in the server. Run each service in a separate terminal window:

```
java `cat conf-quickstart/druid/historical/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/historical:lib/*" io.druid.cli.Main server historical
java `cat conf-quickstart/druid/broker/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/broker:lib/*" io.druid.cli.Main server broker
java `cat conf-quickstart/druid/coordinator/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/coordinator:lib/*" io.druid.cli.Main server coordinator
java `cat conf-quickstart/druid/overlord/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/overlord:lib/*" io.druid.cli.Main server overlord
java `cat conf-quickstart/druid/middleManager/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/middleManager:lib/*" io.druid.cli.Main server middleManager
```

#### Load streaming data

To load streaming data, we are going to push events into Druid over a simple HTTP API. To do this we will use Tranquility, a high level data producer library for Druid.

#### Download Tranquility
```
curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.0.tgz
tar -xzf tranquility-distribution-0.8.0.tgz
cd tranquility-distribution-0.8.0
```
Configuration file : <a href="https://raw.githubusercontent.com/druid-io/druid/master/examples/conf-quickstart/tranquility/server.json">conf-quickstart/tranquility/server.json</a> as part of the Druid distribution for a metrics datasource.

#### Start the Tranquility server process

```
bin/tranquility server -configFile <path_to_druid_distro>/conf-quickstart/tranquility/server.json

With <path_to_druid_distro>:
bin/tranquility server -configFile /home/minoobeyzavi/druid-0.10.0/conf-quickstart/tranquility/server.json
```

<i>The dimensions</i> (attributes you can filter and split on) for this datasource are flexible. It's configured for schemaless dimensions, meaning it will accept any field in your JSON input as a dimension. <i>The metrics</i> (also called measures; values you can aggregate) in this datasource are:

    count
    value_sum (derived from value in the input)
    value_min (derived from value in the input)
    value_max (derived from value in the input)

In a new termianl window, generate some random sample metrics to load into this datasource:

```
cd druid-0.10.0
bin/generate-example-metrics | curl -XPOST -H'Content-Type: application/json' --data-binary @- http://localhost:8200/v1/post/metrics
```

Returns the following, indicating that the HTTP server received 25 events from you, and sent 25 to Druid:

```
{"result":{"received":25,"sent":25}}
```
Note: This takes a few seconds to finish the first time you run it, as Druid resources must be allocated to the ingestion task.

#### Writing an Ingestion Spec (Load Your Own Streaming Data)
Prepare for pushing a stream to Druid by writing a custom Tranquility Server configuration similar to <a href="https://raw.githubusercontent.com/druid-io/druid/master/examples/conf-quickstart/tranquility/server.json">conf-quickstart/tranquility/server.json</a>.

    What should the dataset be called? This is the "dataSource" field of the "dataSchema".
    Which field should be treated as a timestamp? This belongs in the "column" field of the "timestampSpec".
    Which fields should be treated as dimensions? This belongs in the "dimensions" field of the "dimensionsSpec".
    Which fields should be treated as measures? This belongs in the "metricsSpec" field.
    
Let's use a small JSON pageviews dataset as an example, with records like:

```
{"time": "2000-01-01T00:00:00Z", "url": "/foo/bar", "user": "alice", "latencyMs": 32}
```

#### Restarting the server
In a new terminal window, download <a href="https://github.com/minoobeyzavi/Visual-KPI/blob/master/JSON/pageviews-server.json">pageviews-server.json</a> into druid-0.10.0/conf-quickstart/tranquility/: 

```
curl -O https://github.com/minoobeyzavi/Visual-KPI/blob/master/JSON/pageviews-server.json
```

Restart the server to pick up the new configuration file by stopping Tranquility (CTRL-C) and starting it up again.

```
bin/tranquility server -configFile /home/minoobeyzavi/druid-0.10.0/conf-quickstart/tranquility/pageviews-server.json
```

#### JSON-Based Query (testing on Linux)

Save custom query in a JSON file.
JSON query format:
```
{
  "queryType": "timeseries",
  "dataSource": "sample_datasource",
  "granularity": "day",
  "aggregations": [
    { "type": "longSum", "name": "sample_name1", "fieldName": "sample_fieldName1" }
  ],
  "intervals": [ "2012-01-01T00:00:00.000/2012-01-04T00:00:00.000" ],
  "context" : {
    "skipEmptyBuckets": "true"
  }
}
```

Post the query with the Basic format:
```
curl -X POST '<queryable_host>:<port>/druid/v2/?pretty' -H 'Content-Type:application/json' -d @<query_json_file>
```
Note: For further explanation see <b>Reference</b> at the bottom of the page.

Example:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @quickstart/wikiticker-top-pages.json http://localhost:8082/druid/v2/?pretty
```
Finds the most edited articles in this dataset:
```

```

#### Postman Extension

```
Base Address: http://172.0.1.8:8082/druid/v2/
Method: POST
Body: binary
Choose Files: wikiticker-top-pages.json

```
<a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-top-pages.json">wikiticker-top-pages.json</a> finds the most edited articles in the <a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-index.json">wikiticker-index.json</a> dataset which was loaded once into Druid in the above section for loading batch data and now is always available when Druid services are running.

<div align="center"><img src="https://github.com/minoobeyzavi/Visual-KPI/blob/master/Images/postman.png"></img></div>

(Note: Upon completeing this experiment, make sure to Ctrl+C on each terminal window that is running a druid service to stop services before exiting server.)

#### Reference
```
Depending on what druid.storage.type is set to, Druid will upload segments to some Deep Storage.
Local disk is used as the default deep storage.

-L              If server has been moved, redo request on the new location.
-H              Extra header to include in the request.
-X              Custom request method.
Post            Post request.
--data-binary   Post data exactly as specified with no extra processing.
@               What comes after @ is the file name.
@-              Display information after a completed transfer with the format from stdin.
```
