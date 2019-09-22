module CalendariumRomanum
  module Remote
    # Mostly API-compatible with CalendariumRomanum::Calendar
    # (only constructor differs).
    # Instead of computing calendar data, obtains them
    # from a remote calendar API
    # https://github.com/igneus/church-calendar-api
    class Calendar
      extend Forwardable

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
        @uri_scheme = V0::UriScheme.new calendar_uri

        # only for most fundamental computations made locally
        @temporale = Temporale.new(year)
        # only for API compatibility
        @sanctorale = nil
      end

      attr_reader :year
      attr_reader :temporale
      attr_reader :sanctorale
      attr_reader :calendar_uri

      def_delegators :@temporale, :range_check, :season

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

        serialized = @driver.get date, @uri_scheme
        @deserializer.call serialized
      end

      def lectionary
        year_spec['lectionary'].to_sym
      end

      def ferial_lectionary
        year_spec['ferial_lectionary'].to_i
      end

      def ==(obj)
        self.class == obj.class &&
          self.year == obj.year &&
          self.calendar_uri == obj.calendar_uri
      end

      private

      def year_spec
        @year_spec ||= JSON.parse(@driver.year(@year, @uri_scheme))
      end
    end
  end
end
