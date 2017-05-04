## Load streaming to Druid on Linux :: Query with Postman on Windows

To load streaming data, we are going to push events into Druid over a simple HTTP API. To do this we will use [Tranquility], a high level data producer library for Druid.

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

Generate some random sample metrics to load into this datasource

```
bin/generate-example-metrics | curl -XPOST -H'Content-Type: application/json' --data-binary @- http://localhost:8200/v1/post/metrics
```

Prints:

```
{"result":{"received":25,"sent":25}}
```
