module CalendariumRomanum
  module Remote; end
end

%w(
version
calendar
).each do |path|
  require_relative File.join('remote', path)
end
