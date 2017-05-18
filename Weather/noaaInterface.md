 ## NOAA Interface
 
 1. Install new JSON Interface on Server.</br>
 2. Using [Postman](https://www.getpostman.com/docs/introduction):
 
 Add a key to header as "token" with the value "dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy".

 3. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
 4. Enter the following:</br>
 ```
 Base Address: https://www.ncdc.noaa.gov/cdo-web/api/v2/
 ```
 Other useful addresses:
 ```
 Data Categories: https://www.ncdc.noaa.gov/cdo-web/api/v2/datasets
 ```
 
 
 ### Current Data
 (Data availability is varied per location and dates back to a recent date.)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:94103&units=standard&startdate={RECENTDATE}&enddate={RECENTDATE}
 Result Base Path: .results
 Value Field: {2}.value
 Timestamp Field: {2}.date
  ```
  
 ### Forecast (Trend Data)
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:94103&units=standard&startdate={STARTDATE}&enddate={ENDDATE}
 Result Base Path: .results
 Value Field: {2}.value
 Timestamp Field: {2}.date
 ```
 and enter start & end dates manually.
 
 ### Historical Data
 ```
 Request URI: data?datasetid=GHCND&locationid=ZIP:94103&units=standard&startdate={TIMESTAMP}&enddate={TIMESTAMP}
 Result Base Path: .results
 Value Field: {2}.value
 Timestamp Field: {2}.date
 ```
 
 5. Test.
 6. Add corresponding KPIs to the designer.

### Question:
How to pass the results to our Visual KPI software using Postman?

## NOAA Notes
https://www.ncdc.noaa.gov/cdo-web/webservices/v2#data
</br>token:	dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy

#### datasetid 
Required. Accepts a single valid dataset id. Data returned will be from the dataset specified e.g. GHCND.

#### startdate
Required. Accepts valid ISO formated date (YYYY-MM-DD) or date time (YYYY-MM-DDThh:mm:ss). Data returned will be after the specified date. Annual and Monthly data will be limited to a ten year range while all other data will be limted to a one year range e.g. 1763-01-01.

#### enddate
Required. Accepts valid ISO formated date (YYYY-MM-DD) or date time (YYYY-MM-DDThh:mm:ss). Data returned will be before the specified date. Annual and Monthly data will be limited to a ten year range while all other data will be limted to a one year range e.g. 2017-04-26.

#### locationid
Optional. Accepts a valid location id or a chain of location ids seperated by ampersands. Data returned will contain data for the location(s) specified e.g. ZIP:94103. There are other location categories such as CITY however, data availablity is limited.

#### units
Optional. Accepts the literal strings 'standard' or 'metric'. Data will be scaled and converted to the specified units. If a unit is not provided then no scaling nor conversion will take place.
