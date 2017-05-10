## Streaming Data

To load streaming data, we are going to push events into Druid over a simple HTTP API. To do this we will use Tranquility, a high level data producer library for Druid.

#### Start Tranquility

To download file:

```
cd druid-0.10.0
curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.0.tgz
tar -xzf tranquility-distribution-0.8.0.tgz
```

To prepare for pushing a stream of a new dataset to Druid, modifying the tranquility server <a href="https://raw.githubusercontent.com/druid-io/druid/master/examples/conf-quickstart/tranquility/server.json">configuration file</a>:

    sudo nano conf-quickstart/tranquility/server.json

1. "dataSource": name of the dataset
2. "column" field of the "timestampSpec": name of the timestamp attribute
3. "dimensions" field of the "dimensionsSpec": list of attributes with string values
4. "metricsSpec" field: list of attributes with numeric values

Example:
```
"dataSources" : {
      "pageviews" : {
      "spec" : {
        "dataSchema" : {
          "dataSource" : "pageviews",
```
```
 "timestampSpec": {
       "format": "auto",
       "column": "time"
  }
```
```
"dimensionsSpec": {
       "dimensions": ["url", "user", "latencyMs"]
  }
```

To Start server:

```
cd tranquility-distribution-0.8.0
bin/tranquility server -configFile /home/...<path_to_druid_distribution>.../druid-0.10.0/conf-quickstart/tranquility/server.json
```

#### Load Data

Example:
```
{"time": "2017-05-08T19:42:52Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 32}
{"time": "2017-05-08T19:42:53Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 11}
{"time": "2017-05-08T19:42:54Z", "url": "/foo/bar", "user": "Alice", "latencyMs": 45}
```

Druid streaming ingestion requires relatively current messages (relative to a slack time controlled by the windowPeriod value), so you should replace 2000-01-01T00:00:00Z in these messages with the current time in ISO8601 format. You can get this in a new terminal window:

```
python -c 'import datetime; print(datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%SZ"))'
```

Update the timestamps in the JSON above, and save it to a file named pageviews.json, then POST it to Druid:

```
curl -XPOST -H'Content-Type: application/json' --data-binary @pageviews.json http://localhost:8200/v1/post/pageviews
```
Output indicates that the HTTP server received 3 events from you, and sent 3 to Druid:

```
{"result":{"received":3,"sent":3}}
```
This dataset is always going to be available when Druid services are running.
(If you see "sent":0 this likely means that your timestamps are not recent enough. Try adjusting your timestamps and re-sending your data.)

#### Select Query

A select query displays raw Druid rows in the time interval specified.

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

Download query and specify the timestamp interval according to your dataset:
```
curl -O https://raw.githubusercontent.com/minoobeyzavi/Visual-KPI/master/JSON/selectQuery.json
sudo nano selectQuery.json
```
Post query:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @selectQuery.json http://localhost:8082/druid/v2/?pretty
```
Query result:
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


<div align="center"><img src="https://github.com/minoobeyzavi/Visual-KPI/blob/master/Images/postman-streamingData.png"></img></div>


#### Reference
```
Depending on what druid.storage.type is set to, Druid will upload segments to some Deep Storage.
Local disk is used as the default deep storage.

Dimensions      Attributes you can filter and split on.
Metrics         Values you can aggregate.
-L              If server has been moved, redo request on the new location.
-H              Extra header to include in the request.
-X              Custom request method.
-O              Write output to <file> instead of stdout.
Post            Post request.
--data-binary   Post data exactly as specified with no extra processing.
@               What comes after @ is the file name.
```
