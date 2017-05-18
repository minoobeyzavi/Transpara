## weatherbit.io
 
 1. Install new JSON Interface on Server.</br>
 2. Using [Postman](https://www.getpostman.com/docs/introduction):
 
 Add a key to header as "token" with the value "dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy" obtained from the [Token Request Page](https://www.ncdc.noaa.gov/cdo-web/token).

 3. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
 4. Enter the following:</br>
 ```
 Base Address  https://www.ncdc.noaa.gov/cdo-web/api/v2/
 ```
 
 ### Current Data
 (Data availability is varied per location and dates back to a recent date.)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:{1}&units=standard&startdate={RECENTDATE}&enddate={RECENTDATE}
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
https://www.weatherbit.io/api#/Historical32Weather32Data
</br>token:	a6b89fe6ccd5469484569d88a6adc3df

 Useful Addresses:
 ```
 Datasets  https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets
 Data Categories https://www.ncdc.noaa.gov/cdo-web/api/v2/datacategories
 Locations in GHCND Dataset  https://www.ncdc.noaa.gov/cdo-web/api/v2/locations?datasetid=GHCND
 ```

#### datasetid 
Required. A single valid dataset id e.g. GHCND.

#### startdate & enddate
Required. (YYYY-MM-DD) or date time (YYYY-MM-DDThh:mm:ss) format. Annual and Monthly data will be limited to a ten year range while all other data will be limited to a one year range.

#### locationid
Optional. A valid location id or a chain of location ids seperated by ampersands e.g. ZIP:94103.

#### units
Optional. Accepts 'standard' or 'metric'.
