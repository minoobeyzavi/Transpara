 ## forecast.io
 
 1. Install new JSON Interface on Server.</br>
 2. Clear out Base Address and all fields related to Current Value, Trend Data, Historical Value, Historcial Data.</br>
 4. Enter the following:</br>
 ```
 Base Address  https://api.darksky.net/forecast/
 ```
 
 ### Current Data
 ```
 Request URI: ab264c5a62b09962844b4a22da0a4f01/{latitude},{longitude}?exclude=minutely,hourly,daily,alerts,flags
 Result Base Path: .currently
 Value Field: .tempreture
 Timestamp Field: .time
 ```
 and enter latitude and longitude manually.
 
 ### Forecast (Trend Data)
 ```
 Request URI: ab264c5a62b09962844b4a22da0a4f01/{latitude},{longitude}?exclude=currently,minutely,hourly,alerts,flags
 Result Base Path: .daily.data
 Value Field: .tempretureMin
 Timestamp Field: .time
 ```
 
 ### Historical Data
 ```
 Request URI: ab264c5a62b09962844b4a22da0a4f01/{latitude},{longitude},{time}?exclude=currently,hourly,flags
 Result Base Path: .daily.data
 Value Field: .tempretureMin
 Timestamp Field: .time
 ```
 and enter time manually.
 
 ```
 Example:
 Latitude 37.774929
 Longitude -122.419416
 Time 1490005680
 ```
 
 5. Test.
 6. Add corresponding KPIs to the designer.


## Notes
[API Docs](https://darksky.net/dev/docs)
</br>Key	ab264c5a62b09962844b4a22da0a4f01

[Get Latitude and Longitude](http://www.latlong.net/)</br>
[Convert to Unix Time Stamp](https://www.epochconverter.com/)

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
