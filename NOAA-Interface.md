 ## Interface Instructions
 
 1. Install new JSON Interface on Server.</br>
 2. Using [Postman](https://www.getpostman.com/docs/introduction):
 
 Add a key to header as "token" with the value "dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy".
 
 3. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
 4. Enter the following:</br>
 ```
 Base Address: https://www.ncdc.noaa.gov/cdo-web/api/v2/
 ```
 
 ### Current Data
 ```
 Request URI: 
 Result Base Path: 
 Value Field: 
  Timestamp Field: 
  ```
  
 ### Forecast (Trend Data)
 ```
 Request URI: 
 Result Base Path: 
 Value Field: 
 Timestamp Field: 
 ```
 and enter start & end dates manually.
 ### Historical Data
 ```
 Request URI: 
 Result Base Path: 
 Value Field: 
 Timestamp Field: 
 ```
 
 5. Test.
 6. Add corresponding KPIs to the designer.
 
## NOAA Notes
https://www.ncdc.noaa.gov/cdo-web/webservices/v2#data
</br>token:	dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy
