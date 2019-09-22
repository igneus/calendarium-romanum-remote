module CalendariumRomanum
  module Remote; end
end

require 'httpi'
require 'multi_json'
require 'dry-schema'

%w(
version
calendar
driver
errors
v0/denormalizer
v0/uri_scheme
).each do |path|
  require_relative File.join('remote', path)
end
