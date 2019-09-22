module CalendariumRomanum
  module Remote
    module V0
      class Deserializer
        def day(day_json)
          season_sym = day_json['season'].to_sym

          CalendariumRomanum::Day.new(
            date: Date.parse(day_json['date']),
            season: CalendariumRomanum::Seasons.all.find {|s| s.symbol == season_sym},
            season_week: day_json['season_week'],
            celebrations: day_json['celebrations'].collect do |c|
              colour_sym = c['colour'].to_sym

              CalendariumRomanum::Celebration.new(
                c['title'],
                CalendariumRomanum::Ranks[c['rank_num']],
                CalendariumRomanum::Colours.all.find {|c| c.symbol == colour_sym }
              )
            end
          )
        end

        def year(year_json)
          # no denormalization takes place
          year_json
        end
      end
    end
  end
end
