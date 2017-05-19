 ## forecast.io
 
 1. Install new JSON Interface on Server.</br>
 2. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
 4. Enter the following:</br>
 ```
 Base Address  https://api.darksky.net/forecast/
 ```
 
 ### Current Data
 (Data availability is varied per location and dates back to a recent date.)
 ```
 Request URI: ab264c5a62b09962844b4a22da0a4f01/{latitude},{longitude}
 Result Base Path: .results
 Value Field: [2].value
 Timestamp Field: [2].date
  ```
  
 ### Forecast (Trend Data)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={STARTDATE}&enddate={ENDDATE}
 Result Base Path: .results
 Value Field: [2].value
 Timestamp Field: [2].date
 ```
 and enter start & end dates manually.
 
 ### Historical Data
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={TIMESTAMP}&enddate={TIMESTAMP}
 Result Base Path: .results
 Value Field: [2].value
 Timestamp Field: [2].date
 ```
 
 5. Test.
 6. Add corresponding KPIs to the designer.

### Question:
How to pass the results to our Visual KPI software using Postman?

## Notes
https://darksky.net/dev/docs
</br>Key:	ab264c5a62b09962844b4a22da0a4f01

 Useful Addresses:
 ```
 Datasets  https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets
 Data Categories https://www.ncdc.noaa.gov/cdo-web/api/v2/datacategories
 Locations in GHCND Dataset  https://www.ncdc.noaa.gov/cdo-web/api/v2/locations?datasetid=GHCND
 ```
<b>latitude</b> required
The latitude of a location (in decimal degrees). Positive is north, negative is south.

<b>longitude</b> required
The longitude of a location (in decimal degrees). Positive is east, negative is west.

<b>exclude=[blocks]</b> optional
Exclude some number of data blocks from the API response. This is useful for reducing latency and saving cache space. The value blocks should be a comma-delimeted list (without spaces) of any of the following:

currently
minutely
hourly
daily
alerts
flags


#### startdate & enddate
Required. (YYYY-MM-DD) or date time (YYYY-MM-DDThh:mm:ss) format. Annual and Monthly data will be limited to a ten year range while all other data will be limited to a one year range.

#### units
Optional. Accepts 'standard' or 'metric'.
