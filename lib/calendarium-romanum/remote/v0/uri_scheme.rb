module CalendariumRomanum
  module Remote
    module V0
      class UriScheme
        def initialize(calendar_uri)
          @calendar_uri =
            calendar_uri +
            (calendar_uri.end_with?('/') ? '' : '/')
        end

        def day(date)
          URI(@calendar_uri + "#{date.year}/#{date.month}/#{date.day}")
        end

        def year(year)
          URI(@calendar_uri + year.to_s)
        end
      end
    end
  end
end
