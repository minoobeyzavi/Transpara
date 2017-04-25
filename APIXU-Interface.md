<h3>Interface Instructions</h3>

1. Install new JSON Interface on Server.</br>
2. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
3. Enter the following:</br>
Base Address: https://api.apixu.com/v1/

<h1>Current Weather</h1>
Request URI: Object name and parameter</br>
Result Base Path:</br>
Value Field:</br>
Timestamp:</br>

<h1>Forecast (Trend Data)</h1>
Request URI: Object name and parameter</br>
Result Base Path:  </br>
Value Field:</br>
Timestamp:</br>

<h1>Historical Data</h1>
Request URI: Object name and parameter</br>
Result Base Path:</br>
Value Field:</br>
Timestamp:</br>

4. Test

<h3>Questions:</h3>
What Data?

<h3>API Notes</h3>
Real-time weather</br>
10 day weather forecast</br>
Astronomy</br>
Time zone</br>
Location data</br>
Search or Autocomplete API</br>
Historical weather


Examples:</br>

http://api.apixu.com/v1/current.json?key=<YOUR_API_KEY>&q=London</br>
http://api.apixu.com/v1/forecast.json?key=<YOUR_API_KEY>&q=07112&days=7</br>
forcast: Number of days between 1 and 10. If not provided then only today's weather is returned.</br>
http://api.apixu.com/v1/search.json?key=<YOUR_API_KEY>&q=lond</br>
Latitude and Longitude q=48.8567,2.3508</br>
city name q=Paris</br>
zip q=10001</br>
metar:<metar code> q=metar:EGLL</br>
iata:<3 digit airport code> q=iata:DXB</br>
auto:ip IP lookup q=auto:ip</br>
IP address q=100.0.0.1</br>


Details:

forecast: 'dt' should be between today and next 10 day dt=2017-04-21.</br>
history: 'dt' should be on or after dt=2015-01-01 or unixdt=1490227200.</br>
history: 'end_dt' or 'unixend_dt' should be on or after dt=2015-01-01.</br>
history: 'end_dt' should be greater than 'dt' and difference should not be more than 30 days.</br>
Restricting forecast or history output to a specific hour in a given day: 5 pm -> hour=17</br>
lang=fr -> French; returns 'condition:text'.


Current Weather:

Current Object: last_updated, last_updated_epoch, temp_c, temp_f, feelslike_c	, feelslike_f,</br>
condition:text	, condition:icon, condition:code, wind_mph, wind_kph, wind_degree, wind_dir, wind_degree,</br>
pressure_mb, pressure_in, precip_mm, precip_in, humidity, cloud, feelslike_c, feelslike_f, is_day


Forcast & Hisotry:

Forecast Object: astronomy data, day weather forecast and hourly interval weather information for a given city.</br>
forecastday: Parent element. forecastday -> day, forecastday -> astro, forecastday -> hour, date, date_epoch

day Element: maxtemp_c, maxtemp_f, mintemp_c, mintemp_f, avgtemp_c, avgtemp_f, maxwind_mph, maxwind_kph,</br>
totalprecip_mm, totalprecip_in, avgvis_km, avgvis_miles, avghumidity, condition:text, condition:icon, condition:code

astro Element: sunrise, sunset, moonrise, moonset

hour Element: time_epoch, time	string, temp_c, temp_f, condition:text, condition:icon, condition:code, wind_mph,</br> 
wind_kph, wind_degree, wind_dir, pressure_mb, pressure_in, precip_mm, precip_in, humidity, cloud, feelslike_c,</br> 
feelslike_f, windchill_c, windchill_f, heatindex_c, heatindex_f, dewpoint_c, dewpoint_f, will_it_rain, will_it_snow,</br>
is_day, vis_km, vis_miles

http://www.apixu.com/doc/conditions.json -> Multi-language translations of weather condition text</br>
https://cdn.apixu.com/weather.zip -> Weather Icons


Search/Autocomplete:

Returns matching cities/towns as an array of Location object w/o tz_id, localtime_epoch and localtime.</br>
Location Object: lat, lon, name, region, country, tz_id, localtime_epoch, localtime
