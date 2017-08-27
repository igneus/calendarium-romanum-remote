module CalendariumRomanum
  module Remote
    module Drivers
      def self.get(api_version, driver_id)
        if api_version == :v0
          if driver_id == :net_http
            return NetHttpDriver.new
          else
            raise ArgumentError.new("Unsupported driver #{driver_id}")
          end
        else
          raise ArgumentError.new("Unsupported API version #{api_version.inspect}")
        end
      end
    end
  end
end
