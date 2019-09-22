module CalendariumRomanum
  module Remote
    module V0
      class Denormalizer
        def day(day_json)
          check day_json, DaySchema

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
          check year_json, YearSchema

          # no denormalization takes place
          year_json
        end

        protected

        def check(data, schema)
          errors = schema.call(data).errors

          unless errors.empty?
            raise InvalidDataError.new "Invalid data: #{errors.to_h}"
          end
        end

        DaySchema = Dry::Schema.JSON do
          required(:date).filled(:string, format?: /^\d{4}-\d{2}-\d{2}$/)
          required(:season).filled(:string)
          required(:season_week).filled(:integer)
          required(:celebrations).array(:hash) do
            required(:title).filled(:string)
            required(:colour).filled(:string)
            required(:rank_num).filled(:float)
          end
        end

        YearSchema = Dry::Schema.JSON do
          required(:lectionary).filled(:string, included_in?: %w(A B C))
          required(:ferial_lectionary).filled(:integer, included_in?: [1, 2])
        end
      end
    end
  end
end
