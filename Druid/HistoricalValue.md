## Lookup Historcial Values

A Select Query finds Druid rows with the timestamp being in the interval specified (inculding the start date and before the end date). With threshold being set to 1, we would only receive one row with values exactly corresponding or closest to the start date of the interval.

```
{
  "queryType": "select",
  "dataSource": "clicks",
  "descending": "false",
  "dimensions":[],
  "metrics":[],
  "granularity": "all",
  "intervals": [
    "2017-05-08T20:22:27Z/2017-05-08T20:22:28Z"
  ],
  "pagingSpec":{"pagingIdentifiers": {}, "threshold":1}
}
```

Post the query on Linux:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @historicalSelect.json http://localhost:8082/druid/v2/?pretty
```

Output:
```
[ {
  "timestamp" : "2017-05-08T20:22:28.000Z",
  "result" : {
    "pagingIdentifiers" : {
      "clicks_2017-05-08T20:22:28.000Z_2017-05-08T20:22:29.000Z_2017-05-08T20:26:19.711Z" : 0
    },
    "dimensions" : [ "user", "url", "latencyMs" ],
    "metrics" : [ ],
    "events" : [ {
      "segmentId" : "clicks_2017-05-08T20:22:28.000Z_2017-05-08T20:22:29.000Z_2017-05-08T20:26:19.711Z",
      "offset" : 0,
      "event" : {
        "timestamp" : "2017-05-08T20:22:28.000Z",
        "url" : "/foo/bar",
        "user" : "Alice",
        "latencyMs" : "32"
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
Choose Files: historicalSelect.json

```

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
