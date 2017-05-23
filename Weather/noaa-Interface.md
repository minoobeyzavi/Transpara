 ## NOAA
 
 1. Using [Postman](https://www.getpostman.com/docs/introduction):
 
 Add a key to header as "token" with the value "dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy" obtained from [Token Request Page](https://www.ncdc.noaa.gov/cdo-web/token).

 ```
 Base Address  https://www.ncdc.noaa.gov/cdo-web/api/v2/
 ```
 
 ### Current Data
 (Data availability is varied per location and dates back to a recent date.)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={RECENTDATE}&enddate={RECENTDATE}
 Result Base Path: .results
 Value Field: temperatureMax.value
 Timestamp Field: temperatureMax.value
  ```
  
 ### Forecast (Trend Data)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={STARTDATE}&enddate={ENDDATE}
 Result Base Path: .results
 Value Field: temperatureMax.value
 Timestamp Field: temperatureMax.value
 ```
 and enter start & end dates manually.
 
 ### Historical Data
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={TIMESTAMP}&enddate={TIMESTAMP}
 Result Base Path: .results
 Value Field: temperatureMax.value
 Timestamp Field: temperatureMax.date
 ```

## Notes
https://www.ncdc.noaa.gov/cdo-web/webservices/v2#data
</br>token:	dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy
[Token Request](https://www.ncdc.noaa.gov/cdo-web/token)

 Useful Addresses:
 ```
 Locations in GHCND Dataset  https://www.ncdc.noaa.gov/cdo-web/api/v2/locations?datasetid=GHCND
 Location Categories  https://www.ncdc.noaa.gov/cdo-web/api/v2/locationcategories
 ```

<b>datasetid</b>Required</br> 
A single valid dataset id e.g. datasetid=GHCND.

<b>startdate & enddate</b>Required</br>
(YYYY-MM-DD) format e.g. startdate=2017-01-01. Annual and Monthly data will be limited to a ten year range while all other data will be limited to a one year range.

<b>locationid</b>Optional</br>
A valid location id or a chain of location ids seperated by ampersands e.g. ZIP:94103.

<b>units</b>Optional</br>
Accepts 'standard' or 'metric'.

<b>limit</b>Optional</br>
Default is 25. Limits the number of results in the response. Maximum is 1000.
