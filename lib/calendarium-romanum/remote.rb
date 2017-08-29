module CalendariumRomanum
  module Remote; end
end

require 'net/http'
require 'json'

%w(
version
calendar
drivers
drivers/net_http_driver
errors
v0/deserializer
).each do |path|
  require_relative File.join('remote', path)
end
