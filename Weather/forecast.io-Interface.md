 ## forecast.io
 
 1. Install new JSON Interface on Server.</br>
 2. Clear out Base Address and all fields related to Current Value, Trend Data and Historical Value.</br>
 4. Enter the following:</br>
 ```
 Base Address  https://api.darksky.net/forecast/ab264c5a62b09962844b4a22da0a4f01/
 ```
 
 ### Current Data
 ```
 Request URI: {0},{1}?exclude=minutely,hourly,daily,alerts,flags
 Result Base Path: currently
 Value Field: .temperature
 Timestamp Field: .time
 ```
 and enter latitude and longitude manually.
 
 ### Daily Forecast (Trend Data)
 
 This returns data for the next week regardless of what is specified for Start and End Time in Test.
 
 ```
 Request URI: {0},{1}?exclude=currently,minutely,hourly,alerts,flags
 Result Base Path: daily.data
 Value Field: .temperatureMin
 Timestamp Field: .time
 ```
 
 ### Hourly Forecast (Trend Data)
 
 This returns data for the next 48 hours regardless of what is specified for Start and End Time in Test.
 
 ```
 Request URI: {0},{1}?exclude=currently,daily,minutely,alerts,flags
 Result Base Path: hourly.data
 Value Field: .temperature
 Timestamp Field: .time
 ```
 
 ### Historical Data
 
In Visual KPI Server Manager, make sure to use the Historical Data row for this query and not Historical Value. This returns data for the Timestamp specified in {2} parameter in Unix or string format (see example parameters below), regardless of what is specified as Start and End Time in Test.
 
 ```
 Request URI: {0},{1},{2}?exclude=currently,hourly,flags
 Result Base Path: daily.data
 Value Field: .temperatureMin
 Timestamp Field: .time
 ```
 and enter latitude, longitude and time manually.
 
 ```
 Example:
 Latitude 37.774929
 Longitude -122.419416
 Epoch Time 1483293600
 String Time 2017-01-01T10:00:00
 
 Enter lookup parameters as:
 37.774929|-122.419416|1483293600
 
 or
 
 37.774929|-122.419416|2017-01-01T10:00:00
 ```
 
 5. Test.
 6. Add corresponding KPIs to the designer.


## Notes
[API Docs](https://darksky.net/dev/docs)</br> 
First 1000 calls per day are free.</br>
<b>Key</b>	ab264c5a62b09962844b4a22da0a4f01</br>
<b>Backup Key</b> (In case you have reached the daily 1000-call-limit for the purposes of testing) 5d30be11e33410306a009d4578d042c1

[Get Latitude and Longitude](http://www.latlong.net/)</br>
[Convert to Unix Timestamp](https://www.epochconverter.com/)

<b>latitude</b> required</br>
The latitude of a location (in decimal degrees). Positive is north, negative is south.

<b>longitude</b> required</br>
The longitude of a location (in decimal degrees). Positive is east, negative is west.

<b>exclude=[blocks]</b> optional</br>
Exclude some number of data blocks from the API response. This is useful for reducing latency and saving cache space. The value blocks should be a comma-delimeted list (without spaces) of any of the following:

* currently
* minutely
* hourly
* daily
* alerts
* flags

<b>time</b> required for historical data</br>
A UNIX time or a string formatted as: [YYYY]-[MM]-[DD]T[HH]:[MM]:[SS][timezone]. timezone should either be omitted (to refer to local time for the location being requested), Z (referring to GMT time), or +[HH][MM] or -[HH][MM] for an offset from GMT in hours and minutes. The timezone is only used for determining the time of the request; the response will always be relative to the local time zone.

<b>units=[units]</b> optional</br>
Return weather conditions in the requested units. [units] should be one of the following:

* auto: automatically select units based on geographic location
* ca: same as si, except that windSpeed is in kilometers per hour
* uk2: same as si, except that nearestStormDistance and visibility are in miles and windSpeed is in miles per hour
* us: Imperial units (the default)
* si: SI units
