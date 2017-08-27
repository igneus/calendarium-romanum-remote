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
    end
  end
end
