module CalendariumRomanum
  module Remote
    module Drivers
      # Communicates with the remote API using Ruby standard library
      class NetHttpDriver
        def get(date, calendar_uri)
          uri_str =
            calendar_uri +
            (calendar_uri.end_with?('/') ? '' : '/') +
            "#{date.year}/#{date.month}/#{date.day}"
          uri = URI(uri_str)
          Net::HTTP.get uri
        end
      end
    end
  end
end
