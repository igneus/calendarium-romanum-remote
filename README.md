# calendarium-romanum-remote

Extends [calendarium-romanum][caro] with a new class
`CalendariumRomanum::Remote::Calendar`.
It is (only exception being the constructor) API-compatible
with `CalendariumRomanum::Calendar`, but obtains the data
from a [remote calendar API][calapi] instead of computing them.

## Usage

Load by

```
require 'calendarium-romanum'
require 'calendarium-romanum/remote'
```

or by a shortcut

```
require 'calendarium-romanum-remote'
```

```ruby
CR = CalendariumRomanum

# create by specifying a year and remote calendar URI
calendar = CR::Remote::Calendar.new(2016, 'http://calapi.inadiutorium.cz/api/v0/en/calendars/general-la/')

# use the same way as the normal Calendar, get the same return values
day = calendar.day Date.new(2016, 12, 24)
```

## License

freely choose between GNU/LGPL 3 and MIT

[caro]: https://github.com/igneus/calendarium-romanum
[calapi]: https://github.com/igneus/church-calendar-api
