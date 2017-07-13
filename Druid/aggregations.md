# Aggregations

## Config
```
cd conf-quickstart/tranquility/server.json
sudo nano sever.json
"metricsSpec" : [
 { "type" : "count", "name" : "views"},
 { "type" : "doubleSum", "name" : "total_latency", "fieldName" : "latencyMs" },
 { "type" : "variance", "name" : "latency_var", "fieldName" : "latencyMs", "estimator" : "population" }
]

.
.
.

"druid.extensions.directory" : "extensions"
```

#### Include druid-stats as an extension.

These extensions are located in the extensions directory of the distribution.

```
sudo nano druid-0.10.0/conf/druid/_common/common.runtime.properties/common.runtime.properties
```
Add "druid-stats" to the list of extensions:
```
druid.extensions.loadList=[..., "druid-stats",...]
```

#### Restart Tranquility

```
bin/tranquility server -configFile /home/...<path_to_druid_distribution>.../druid-0.10.0/conf-quickstart/tranquility/server.json -Ddruid.extensions.loadList='["druid-stats"]' -Ddruid.extensions.directory=/home/minoobeyzavi/druid-0.9.2/extensions
```
We included the line below in the command to make Tranquility aware of the extensions.
```
-Ddruid.extensions.loadList='["druid-histogram"]' -Ddruid.extensions.directory=/opt/druid/extensions
```

## Average

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
  "pagingSpec":{"pagingIdentifiers": {}, "threshold":25},
  "aggregations" : [
  { "type" : "count", "name" : "views"},
  { "type" : "doubleSum", "name" : "total_latency", "fieldName" : "latencyMs" }
],
"postAggregations" : [{
  "type"   : "arithmetic",
  "name"   : "average_latency",
  "fn"     : "/",
  "fields" : [
    { "type" : "fieldAccess", "fieldName" : "total_latency" },
    { "type" : "fieldAccess", "fieldName" : "views" }
  ]
}]
}
```  
  

## Standard Deviation

Pre-aggregating variance at ingestion time
To use this feature, an "variance" aggregator must be included at indexing time. The ingestion aggregator can only apply to numeric values. If you use "variance" then any input rows missing the value will be considered to have a value of 0.

User can specify expected input type as one of "float", "long", "variance" for ingestion, which is by default "float".
```
{
  "type" : "variance",
  "name" : <output_name>,
  "fieldName" : <metric_name>,
  "inputType" : <input_type>,
  "estimator" : <string>
}
```

To query for results, "variance" aggregator with "variance" input type or simply a "varianceFold" aggregator must be included in the query.

```
{
  "type" : "varianceFold",
  "name" : <output_name>,
  "fieldName" : <metric_name>,
  "estimator" : <string>
}
```

To acquire standard deviation from variance, user can use "stddev" post aggregator.

```
{
  "type": "stddev",
  "name": "<output_name>",
  "fieldName": "<aggregator_name>",
  "estimator": <string>
}
```
