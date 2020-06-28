# Changelog

## [0.3.0] 2020-06-28

### Added

* `Calendar` methods for API compatibility with calendarium-romanum
  up to 0.7.0

### Changed

* calendarium-romanum version requirements loosened

## [0.2.0] 2019-09-22

### Added

* strict validation of incoming data
* distinctive User-Agent request header

### Changed

* use `HTTPi` and `multi_json` abstraction layers
* `CalendariumRomanum::Remote::Calendar` constructor argument
  `api_version` removed, argument `driver` changed semantics
* concept of a "driver" shifted significantly
* `ServerNotFoundError`, `BadRequestError` and `TransportError`
  exceptions dropped
* no attempt is made to translate transport-level exceptions,
  those raised by `HTTPi` are left in place

## [0.1.0] 2017-09-02

*First public release*
