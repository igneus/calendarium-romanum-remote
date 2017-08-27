module CalendariumRomanum
  module Remote
    module V0
      class Deserializer
        def call(day_str)
          parsed = JSON.parse day_str

          season_sym = parsed['season'].to_sym

          CalendariumRomanum::Day.new(
            date: Date.parse(parsed['date']),
            season: CalendariumRomanum::Seasons.all.find {|s| s.symbol == season_sym},
            season_week: parsed['season_week'],
            celebrations: parsed['celebrations'].collect do |c|
              colour_sym = c['colour'].to_sym

              CalendariumRomanum::Celebration.new(
                c['title'],
                CalendariumRomanum::Ranks[c['rank_num']],
                CalendariumRomanum::Colours.all.find {|c| c.symbol == colour_sym }
              )
            end
          )
        end
      end
    end
  end
end
