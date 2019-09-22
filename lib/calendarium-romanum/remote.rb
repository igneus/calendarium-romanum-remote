module CalendariumRomanum
  module Remote; end
end

require 'httpi'
require 'multi_json'

# TODO remove
require 'net/http'
require 'json'

%w(
version
calendar
driver
drivers
drivers/net_http_driver
errors
v0/deserializer
v0/uri_scheme
).each do |path|
  require_relative File.join('remote', path)
end
