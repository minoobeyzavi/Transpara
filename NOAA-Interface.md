## Interface Instructions

1. Install new JSON Interface on Server.</br>
2. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
3. Enter the following:</br>
```
Base Address: https://www.ncdc.noaa.gov/cdo-web/api/v2/
```

### Current Data
```
Request URI: current.json?key=32b04bb6f545444db9b12806172204&q=94103
Result Base Path: current.
Value Field: temp_f
Timestamp Field: last_updated
```

### Forecast (Trend Data)</h3>
```
Request URI: forecast.json?key=32b04bb6f545444db9b12806172204&q=94103&days=7
Result Base Path: forecast
Value Field: forecastday.avgtemp_f
Timestamp Field: forecastday.date
```
or
```
Request URI: forecast.json?key=32b04bb6f545444db9b12806172204&q=94103&dt=2017-01-01&end_dt=2017-01-20
Result Base Path: forecast
Value Field: forecastday.avgtemp_f
Timestamp Field: forecastday.date
```
or
```
Request URI: forecast.json?key=32b04bb6f545444db9b12806172204&q=94103&dt={STARTDATE}&end_dt={ENDDATE}
Result Base Path: forecast
Value Field: forecastday.avgtemp_f
Timestamp Field: forecastday.date
```
and enter start & end dates manually.
### Historical Data
```
Request URI: history.json?key=32b04bb6f545444db9b12806172204&q=94103&dt={TIMESTAMP}
Result Base Path: forecast
Value Field: forecastday.avgtemp_f
Timestamp Field: forecastday.date
```

4. Test.
5. Add corresponding KPIs to the designer.


## NOAA Notes
https://www.ncdc.noaa.gov/cdo-web/webservices/v2#data
Token:	dmvfhINKHBVgAWGFxEsicLiaMAhNKSgy
