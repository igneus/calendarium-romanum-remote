# calendarium-romanum-remote

[![Gem Version](https://badge.fury.io/rb/calendarium-romanum-remote.svg)](https://badge.fury.io/rb/calendarium-romanum-remote)

Extends [calendarium-romanum][caro] with a new class
`CalendariumRomanum::Remote::Calendar`.
It is (only exception being the constructor) API-compatible
with `CalendariumRomanum::Calendar`, but obtains the data
from a [remote calendar API][calapi] instead of computing them.

## What it is good for

There are cases when you can't - or don't want to - setup a
`CalendariumRomanum::Calendar` yourself.
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

```ruby
require 'calendarium-romanum'
require 'calendarium-romanum/remote'
```

or by a shortcut

```ruby
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
rescue CR::Remote::UnexpectedResponseError
  # the server responded with some "unhappy" HTTP status code
rescue CR::Remote::InvalidDataError => err
  # data returned by the server were not understood
rescue HTTPI::Error
  # parent class of lower-level network errors raised by HTTPI -
  # see its documentation or source for the specific exception
  # classes
end
```

## Important implementation details

Under the hood [HTTPi][httpi] is used to issue HTTP requests
and [multi_json][multi_json] for JSON deserialization.
Both gems provide uniform public interfaces while allowing
you to choose among several implementations.
`calendarium-romanum-remote` deliberately does not make any
choice concerning the implementations and leaves this up to you.
There are sensible defaults working out of the box,
but it's advisable to check both gems' documentation to see
what options you have and how to make use of them.

The following example configures `curb` to be used internally
as HTTP client and `oj` as JSON deserializer.

```ruby
require 'curb'
require 'oj'
require 'calendarium-romanum-remote'

HTTPI.adapter = :curb
MultiJson.adapter = :oj
```

## License

freely choose between GNU/LGPL 3 and MIT

[caro]: https://github.com/igneus/calendarium-romanum
[calapi]: https://github.com/igneus/church-calendar-api
[leaky_abstractions]: https://www.joelonsoftware.com/2002/11/11/the-law-of-leaky-abstractions/
[httpi]: http://httpirb.com
[multi_json]: https://github.com/intridea/multi_json
