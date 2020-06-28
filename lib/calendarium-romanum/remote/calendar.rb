module CalendariumRomanum
  module Remote
    # Mostly API-compatible with CalendariumRomanum::Calendar
    # (only constructor differs).
    # Instead of computing calendar data, obtains them
    # from a remote calendar API
    # https://github.com/igneus/church-calendar-api
    class Calendar
      extend Forwardable

      def initialize(year, calendar_uri, driver: nil)
        @year = year
        @calendar_uri = calendar_uri

        @driver =
          driver ||
          Driver.new(
            V0::UriScheme.new(calendar_uri),
            V0::Denormalizer.new
          )

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

      def populates_vespers?
        false
      end

      def day(*args, vespers: false)
        if vespers != false
          throw ArgumentError.new('Vespers data supported, but this implementation currently doesn\'t support computing vespers.')
        end

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

        @driver.day date
      end

      # TODO literally copied from CalendariumRomanum::Calendar
      def [](args)
        if args.is_a?(Range)
          args.map {|date| day(date) }
        else
          day(args)
        end
      end

      # TODO literally copied from CalendariumRomanum::Calendar
      def each
        return to_enum(__method__) unless block_given?

        temporale.date_range
          .each {|date| yield(day(date)) }
      end

      def lectionary
        year_spec['lectionary'].to_sym
      end

      def ferial_lectionary
        year_spec['ferial_lectionary'].to_i
      end

      def ==(b)
        self.class == b.class &&
          self.year == b.year &&
          self.calendar_uri == b.calendar_uri
      end

      private

      def year_spec
        @year_spec ||= @driver.year(@year)
      end
    end
  end
end
