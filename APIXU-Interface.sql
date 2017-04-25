-- What Data? HTTP or HTTPS?

-- Real-time weather
-- 10 day weather forecast
-- Astronomy
-- Time zone
-- Location data
-- Search or Autocomplete API
-- Historical weather

-- Examples:

-- http://api.apixu.com/v1/current.json?key=<YOUR_API_KEY>&q=London
-- http://api.apixu.com/v1/forecast.json?key=<YOUR_API_KEY>&q=07112&days=7
-- forcast: Number of days between 1 and 10. If not provided then only today's weather is returned.
-- http://api.apixu.com/v1/search.json?key=<YOUR_API_KEY>&q=lond
-- Latitude and Longitude q=48.8567,2.3508
-- city name q=Paris
-- zip q=10001
-- metar:<metar code> q=metar:EGLL
-- iata:<3 digit airport code> q=iata:DXB
-- auto:ip IP lookup q=auto:ip
-- IP address q=100.0.0.1

-- Details:

-- forecast: 'dt' should be between today and next 10 day dt=2017-04-21.
-- history: 'dt' should be on or after dt=2015-01-01 or unixdt=1490227200.
-- history: 'end_dt' or 'unixend_dt' should be on or after dt=2015-01-01.
-- history: 'end_dt' should be greater than 'dt' and difference should not be more than 30 days.
-- Restricting forecast or history output to a specific hour in a given day: 5 pm -> hour=17
-- lang=fr -> French; returns 'condition:text'.

-- Current Weather:

-- Current Object: last_updated, last_updated_epoch, temp_c, temp_f, feelslike_c	, feelslike_f,
-- condition:text	, condition:icon, condition:code, wind_mph, wind_kph, wind_degree, wind_dir, wind_degree,
-- pressure_mb, pressure_in, precip_mm, precip_in, humidity, cloud, feelslike_c, feelslike_f, is_day

-- Forcast & Hisotry:

-- Forecast Object: astronomy data, day weather forecast and hourly interval weather information for a given city.
-- forecastday: Parent element. forecastday -> day, forecastday -> astro, forecastday -> hour, date, date_epoch

-- day Element: maxtemp_c, maxtemp_f, mintemp_c, mintemp_f, avgtemp_c, avgtemp_f, maxwind_mph, maxwind_kph,
-- totalprecip_mm, totalprecip_in, avgvis_km, avgvis_miles, avghumidity, condition:text, condition:icon, condition:code

-- astro Element: sunrise, sunset, moonrise, moonset

-- hour Element: time_epoch, time	string, temp_c, temp_f, condition:text, condition:icon, condition:code, wind_mph, 
-- wind_kph, wind_degree, wind_dir, pressure_mb, pressure_in, precip_mm, precip_in, humidity, cloud, feelslike_c, 
-- feelslike_f, windchill_c, windchill_f, heatindex_c, heatindex_f, dewpoint_c, dewpoint_f, will_it_rain, will_it_snow,
-- is_day, vis_km, vis_miles

-- http://www.apixu.com/doc/conditions.json -> Multi-language translations of weather condition text

-- Interfaces:

SELECT value as FROM

union
ORDER BY
