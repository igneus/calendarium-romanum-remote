module CalendariumRomanum
  module Remote
    # Mostly API-compatible with CalendariumRomanum::Calendar
    # (only constructor differs).
    # Instead of computing calendar data, obtains them
    # from a remote calendar API
    # https://github.com/igneus/church-calendar-api
    class Calendar
      def initialize(year, calendar_uri, api_version: :v1, backend: :net_http)
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
      end
    end
  end
end
