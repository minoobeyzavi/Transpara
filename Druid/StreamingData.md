## Load Streaming Data to Druid on Linux :: Query with Postman on Windows

#### Load Streaming Data

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
bin/tranquility server -configFile <path_to_druid_distribution>/conf-quickstart/tranquility/server.json

Example:
bin/tranquility server -configFile /home/minoobeyzavi/druid-0.10.0/conf-quickstart/tranquility/server.json
```



In a new termianl window:
```

bin/generate-example-metrics | curl -XPOST -H'Content-Type: application/json' --data-binary @- http://localhost:8200/v1/post/metrics
```



#### Load Your Own Streaming Data
Prepare for pushing a stream to Druid by writing a custom Tranquility Server configuration similar to <a href="https://raw.githubusercontent.com/druid-io/druid/master/examples/conf-quickstart/tranquility/server.json">conf-quickstart/tranquility/server.json</a>.

    What should the dataset be called? This is the "dataSource" field of the "dataSchema".
    Which field should be treated as a timestamp? This belongs in the "column" field of the "timestampSpec".
    Which fields should be treated as dimensions? This belongs in the "dimensions" field of the "dimensionsSpec".
    Which fields should be treated as measures? This belongs in the "metricsSpec" field.

#### Restarting the server
In a new terminal window, download <a href="https://github.com/minoobeyzavi/Visual-KPI/blob/master/JSON/server.json">server.json</a> into druid-0.10.0/conf-quickstart/tranquility/: 

```
curl -O https://github.com/minoobeyzavi/Visual-KPI/blob/master/JSON/pageviews-server.json
```

```
bin/tranquility server -configFile /home/minoobeyzavi/druid-0.10.0/conf-quickstart/tranquility/server.json
```
#### Sending Data

```
{"time": "2017-05-08T19:42:52Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 32}
{"time": "2017-05-08T19:42:53Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 11}
{"time": "2017-05-08T19:42:54Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 45}
```

Druid streaming ingestion requires relatively current messages (relative to a slack time controlled by the windowPeriod value), so you should replace 2000-01-01T00:00:00Z in these messages with the current time in ISO8601 format. You can get this by running:

```
python -c 'import datetime; print(datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ"))'
```

Update the timestamps in the JSON above, and save it to a file named pageviews.json. Then send it to Druid by running:

```
curl -XPOST -H'Content-Type: application/json' --data-binary @pageviews.json http://localhost:8200/v1/post/pageviews
```

Returns the following, indicating that the HTTP server received 25 events from you, and sent 25 to Druid:

```
{"result":{"received":3,"sent":3}}
```

#### JSON-Based Query

Dimensions: attributes you can filter and split on.
Metrics: values you can aggregate.

Save custom query in a JSON file.
selectQuery.json:
```
{
  "queryType": "select",
  "dataSource": "clicks",
  "descending": "false",
  "dimensions":[],
  "metrics":[],
  "granularity": "all",
  "intervals": [
    "2017-05-08T00:00:00Z/2017-05-09T00:00:00Z"
  ],
  "pagingSpec":{"pagingIdentifiers": {}, "threshold":25}
}
```

Post the query on Linux:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @selectQuery.json http://localhost:8082/druid/v2/?pretty
```
A select query displays raw Druid rows in the time interval specified (inculding the start date and before the end date) in the dataset which was loaded once into Druid in the above section for loading batch data and now is always available when Druid services are running.
```

[ {
  "timestamp" : "2017-05-08T19:42:52.000Z",
  "result" : {
    "pagingIdentifiers" : {
      "clicks_2017-05-08T19:00:00.000Z_2017-05-08T20:00:00.000Z_2017-05-08T19:48:33.015Z" : 2
    },
    "dimensions" : [ "user", "url", "latencyMs" ],
    "metrics" : [ ],
    "events" : [ {
      "segmentId" : "clicks_2017-05-08T19:00:00.000Z_2017-05-08T20:00:00.000Z_2017-05-08T19:48:33.015Z",
      "offset" : 0,
      "event" : {
        "timestamp" : "2017-05-08T19:42:52.000Z",
        "url" : "/foo/bar",
        "user" : "Alice",
        "latencyMs" : "32"
      }
    }, {
      "segmentId" : "clicks_2017-05-08T19:00:00.000Z_2017-05-08T20:00:00.000Z_2017-05-08T19:48:33.015Z",
      "offset" : 1,
      "event" : {
        "timestamp" : "2017-05-08T19:42:53.000Z",
        "url" : "/foo/bar",
        "user" : "Alice",
        "latencyMs" : "11"
      }
    }, {
      "segmentId" : "clicks_2017-05-08T19:00:00.000Z_2017-05-08T20:00:00.000Z_2017-05-08T19:48:33.015Z",
      "offset" : 2,
      "event" : {
        "timestamp" : "2017-05-08T19:42:54.000Z",
        "url" : "/foo/bar",
        "user" : "Alice",
        "latencyMs" : "45"
      }
    } ]
  }
} ]
```

#### Postman Extension

```
Base Address: http://172.0.1.8:8082/druid/v2/
Method: POST
Body: binary
Choose Files: selectQuery.json

```
<a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-top-pages.json">wikiticker-top-pages.json</a> finds the most edited articles in the <a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-index.json">wikiticker-index.json</a> dataset which was loaded once into Druid in the above section for loading batch data and now is always available when Druid services are running.

<div align="center"><img src="https://github.com/minoobeyzavi/Visual-KPI/blob/master/Images/postman-streamingData.png"></img></div>


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
