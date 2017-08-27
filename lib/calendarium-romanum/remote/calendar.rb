module CalendariumRomanum
  module Remote
    # Mostly API-compatible with CalendariumRomanum::Calendar
    # (only constructor differs).
    # Instead of computing calendar data, obtains them
    # from a remote calendar API
    # https://github.com/igneus/church-calendar-api
    class Calendar
      def initialize(year, calendar_uri, api_version: :v0, driver: :net_http)
        @year = year
        @calendar_uri = calendar_uri
        @driver =
          if driver.is_a? Symbol
            # built-in driver specified by a Symbol
            Drivers.get(api_version, driver)
          else
            # driver instance
            driver
          end
        @deserializer = V0::Deserializer.new
      end

      def day(*args)
        # TODO code copied from CalendariumRomanum::Calendar -
        # extract to a separate method
        if args.size == 2
          date = Date.new(@year, *args)
          unless @temporale.date_range.include? date
            date = Date.new(@year + 1, *args)
          end
        else
          date = CalendariumRomanum::Calendar.mk_date *args
          #range_check date
        end

        serialized = @driver.get date, @calendar_uri
        @deserializer.call serialized
      end
    end
  end
end
