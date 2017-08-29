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

          begin
            response = Net::HTTP.get_response uri
          rescue SocketError, Errno::ECONNREFUSED
            raise ServerNotFoundError.new
          end

          if response.code == '200'
            return response.body
          elsif response.code == '400'
            json = JSON.parse(response.body)
            raise BadRequestError.new(json['error'])
          else
            raise RuntimeError.new("Unexpected status #{response.code.inspect}")
          end
        end
      end
    end
  end
end
