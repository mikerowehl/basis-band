# Basis API Access Gem

[![Gem Version](https://badge.fury.io/rb/basis-band.png)](http://badge.fury.io/rb/basis-band)

Includes a command line tool that can be used to either capture the raw JSON
responses from app.mybasis.com, or to convert the metrics from the API
responses into CSV.

## Usage

First off you need to find your userid. The command line tool now provides an
option to output your userid given a username and password on the command line.
Just pass the username and password joined with a colon (:) using the -l
option and you'll get your userid back as output. Assuming your username is
'mikerowehl@gmail.com' and your password is 'pppppp' the command would look
like this:

```
> miker $ basis-band -l mikerowehl@gmail.com:pppppp
1234567890abcdef12345678
```

In this example the userid returned is '1234567890abcdef12345678'. In the rest
of the examples the userid is abbreviated to 'xxxxx'.

If you pass -u and -d options the raw text will be fetched from the API and
output on standard output:

```
> miker $ basis-band -u xxxxx -d 2013-10-14
{"metrics":{"skin_temp":{"min":77.0,"max":95.0,"sum":113642.0,"summary":{"max_skin_temp_per_minute":null...
```

If you want the metric data as CSV instead of raw JSON:

```
> miker $ basis-band -u xxxxx -d 2013-10-14 -c
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

For additional information see the PHP example at
[https://github.com/btroia/basis-data-export](https://github.com/btroia/basis-data-export).
That example includes instructions for finding your userid.

