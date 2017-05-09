## Retrieve Historcial Data

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
  "pagingSpec":{"pagingIdentifiers": {}, "threshold":25}
}
```

Post the query:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @historicalSelect.json http://localhost:8082/druid/v2/?pretty
```

#### Postman Extension

```
Base Address: http://172.0.1.8:8082/druid/v2/
Method: POST
Body: binary
Choose Files: historicalSelect.json

```

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
