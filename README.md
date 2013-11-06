# Basis API Access Gem

[![Gem Version](https://badge.fury.io/rb/basis-band.png)](http://badge.fury.io/rb/basis-band)

Includes a command line tool that can be used to either capture the raw JSON
responses from app.mybasis.com, or to convert the metrics from the API
responses into CSV.

## Usage

There are two different versions of the API available at app.mybasis.com. The
V1 API (which holds most of the detailed data about heartrate and steps) uses a
user id, while the V2 API (which holds information about activities like
walking, running or biking state) uses an access token. You can use the -l
option to the command line tool to dump out both values.
Just pass the username and password joined with a colon (:).
Assuming your username is
'mikerowehl@gmail.com' and your password is 'pppppp' the command would look
like this:

```
> miker $ basis-band -l mikerowehl@gmail.com:pppppp
ID for V1 api: 1234567890abcdef12345678
token for V2 api: abcdef1234567890abcdef1234567890
```

In this example the userid returned is '1234567890abcdef12345678' and the 
token is 'abcdef1234567890abcdef1234567890'.

If you pass -u and -d options the raw text will be fetched from the API and
output on standard output:

```
> miker $ basis-band -u 1234567890abcdef12345678 -d 2013-10-14
{"metrics":{"skin_temp":{"min":77.0,"max":95.0,"sum":113642.0,"summary":{"max_skin_temp_per_minute":null...
```

If you want the metric data as CSV instead of raw JSON:

```
> miker $ basis-band -u 1234567890abcdef12345678 -d 2013-10-14 -c
t,state,skin_temp,heartrate,air_temp,calories,gsr,steps
2013/10/01 00:00:00,inactive,83.8,58,80.6,1.3,0.000439,0
2013/10/01 00:01:00,inactive,83.8,62,80.6,1.4,0.000402,0
2013/10/01 00:02:00,inactive,83.8,64,80.6,1.4,0.000464,0
...
```

If you already have the JSON in a local file, you can pass it in on standard
input and transform it to CSV:

```
> miker $ basis-band -c < cache/2013-10-14.json
t,state,skin_temp,heartrate,air_temp,calories,gsr,steps
2013/10/01 00:00:00,inactive,83.8,58,80.6,1.3,0.000439,0
2013/10/01 00:01:00,inactive,83.8,62,80.6,1.4,0.000402,0
2013/10/01 00:02:00,inactive,83.8,64,80.6,1.4,0.000464,0
...
```

If you want the activity info for a given day pass in the access token using
-t and the date you want with -d:

```
> miker $ basis-band -t abcdef1234567890abcdef1234567890 -d 2013-11-05 | python -mjson.tool
{
    "content": {
        "activities": [
            {
                "actual_seconds": 1323,
                "calories": 118.8,
                "end_time": {
                    "iso": "2013-11-05T22:38:25Z",
                    "time_zone": {
                        "name": "America/Los_Angeles",
                        "offset": -480
                    },
                    "timestamp": 1383691105
                },
                "heart_rate": {
                    "avg": null,
                    "max": null,
                    "min": null
                },
...
```
