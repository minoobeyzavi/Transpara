## Load Streaming to Data Druid on Linux :: Query with Postman on Windows

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
```

The dimensions (attributes you can filter and split on) for this datasource are flexible. It's configured for schemaless dimensions, meaning it will accept any field in your JSON input as a dimension.

The metrics (also called measures; values you can aggregate) in this datasource are:

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