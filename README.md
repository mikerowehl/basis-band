# Basis API Access Gem

This is extremely alpha quality, based on the existing PHP example at
[https://github.com/btroia/basis-data-export](https://github.com/btroia/basis-data-export).
That example includes instructions for finding your userid.

Includes a command line tool that can be used to either capture the raw JSON
responses from app.mybasis.com, or to convert the metrics from the API
responses into CSV. Assuming your userid is represented by xxxxx, here are
some simple examples.

If you pass -u and -d options the raw text will be fetched from the API and
output on standard output:

```
> miker $ basis-band -c xxxxx -d 2013-10-14
{"metrics":{"skin_temp":{"min":77.0,"max":95.0,"sum":113642.0,"summary":{"max_skin_temp_per_minute":null...
```

If you want the metric data as CSV instead of raw JSON:

```
> miker $ basis-band -c xxxxx -d 2013-10-14 -c
t,skin_temp,heartrate,air_temp,calories,gsr,steps
2013/10/14 00:00:00,93.2,69,92.3,1.3,0.00128,0
2013/10/14 00:01:00,93.3,68,92.3,1.3,0.00136,0
2013/10/14 00:02:00,94.3,68,92.3,1.3,0.00156,0
...
```

If you already have the JSON in a local file, you can pass it in on standard
input and transform it to CSV:

```
> miker $ basis-band -c < cache/2013-10-14.json
t,skin_temp,heartrate,air_temp,calories,gsr,steps
2013/10/14 00:00:00,93.2,69,92.3,1.3,0.00128,0
2013/10/14 00:01:00,93.3,68,92.3,1.3,0.00136,0
2013/10/14 00:02:00,94.3,68,92.3,1.3,0.00156,0
...
```
