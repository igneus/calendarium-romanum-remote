# calendarium-romanum-remote

[![Gem Version](https://badge.fury.io/rb/calendarium-romanum-remote.svg)](https://badge.fury.io/rb/calendarium-romanum-remote)

Extends [calendarium-romanum][caro] with a new class
`CalendariumRomanum::Remote::Calendar`.
It is (only exception being the constructor) API-compatible
with `CalendariumRomanum::Calendar`, but obtains the data
from a [remote calendar API][calapi] instead of computing them.

## What it is good for

There are cases when you can't - or don't want to - setup a `Calendar`
yourself.
Maybe you don't have all the necessary data, but there is a calendar
API instance which has them.
Maybe you always want to have the most accurate and up-to-date data,
but you don't want to watch for fixes and updates
to `calendarium-romanum`, and there is a regularly updated instance
of calendar API out there.
In all these cases it is convenient to use `calendarium-romanum-remote`
instead of building a regular `Calendar` in your application.

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

As most abstractions, also the one of `Remote::Calendar` is
[leaky][leaky_abstractions]:
a whole bunch of errors specific to the network communication
taking place in the background can occur.

```ruby
CR = CalendariumRomanum

calendar = CR::Remote::Calendar.new(2016, 'http://calapi.inadiutorium.cz/api/v0/en/calendars/general-la/')

begin
  day = calendar.day Date.new(2016, 12, 24)
rescue CR::Remote::ServerNotFoundError
  # either you used a bad URI or the server disappeared
rescue CR::Remote::TransportError => err
  # probably not your fault, you may want to retry later

  # original error raised by the underlying network layer is available
  original_exception = err.cause
rescue CR::Remote::BadRequestError
  # this suggests that you either specified wrong path
  # (it must be a *calendar* path, not e.g. API base path!)
  # or the server runs some other API version than implemented;
  # the error message should be helpful
end
```

If you are not at all interested in details of the fail,
you can just handle the parent of all errors raised by the library:

```ruby
CR = CalendariumRomanum

calendar = CR::Remote::Calendar.new(2016, 'http://calapi.inadiutorium.cz/api/v0/en/calendars/general-la/')

begin
  day = calendar.day Date.new(2016, 12, 24)
rescue CR::Remote::Error
  puts 'fail'
end
```

## License

freely choose between GNU/LGPL 3 and MIT

[caro]: https://github.com/igneus/calendarium-romanum
[calapi]: https://github.com/igneus/church-calendar-api
[leaky_abstractions]: https://www.joelonsoftware.com/2002/11/11/the-law-of-leaky-abstractions/
