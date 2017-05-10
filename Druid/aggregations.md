## Aggregations

#### Include druid-stats as an extension.

These extensions are located in the extensions directory of the distribution.

```
sudo nano druid-0.10.0/conf/druid/_common/common.runtime.properties/common.runtime.properties
```
Add "druid-stats" to the list of extensions:
```
druid.extensions.loadList=[..., "druid-stats",...]
```

#### Average

#### Standard Deviation

