# Basis API Access Gem

This is extremely alpha quality, based on the existing PHP example at
[https://github.com/btroia/basis-data-export](https://github.com/btroia/basis-data-export).
That example includes instructions for finding your userid.

The command line tool here does just a one-day dump of the JSON data raw. Pass
it your userid and a date, and it'll spit back the raw data on stdout. For
instance to dump my data for Oct 14th, 2013 (of course, xxxxx represents my 
userid, but I'm not posting that):

```
> miker $ basis-band xxxxxxxxxxxxxxxxxxxxxxxx 2013-10-14
```

Or if you want to pretty print and paginate:

```
> miker $ basis-band xxxxxxxxxxxxxxxxxxxxxxxx 2013-10-14 | python -mjson.tool | more
{
    "bodystates": [
        [
            1381816740,
            1381842000,
            "sleep"
...
...
```

Just pushing up what I have so far, this is really meant to be a way to export to
CSV eventually so I can use this data in spreadsheets. To be done.
