# calendarium-romanum-remote

Extends [calendarium-romanum][caro] with a new class
`CalendariumRomanum::Remote::Calendar`.
It is (only exception being the constructor) API-compatible
with `CalendariumRomanum::Calendar`, but obtains the data
from a [remote calendar API][calapi] instead of computing them.

```ruby
CR = CalendariumRomanum

# create by specifying a year and remote calendar URI
calendar = CR::Remote::Calendar.new(2016, 'http://calapi.inadiutorium.cz/api/v0/en/calendars/general-la/')

# use the same way as the normal Calendar, get the same return values
day = calendar.get Date.new(2016, 12, 24)
```

[caro]: https://github.com/igneus/calendarium-romanum
[calapi]: https://github.com/igneus/church-calendar-api