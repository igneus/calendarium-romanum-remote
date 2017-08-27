require_relative 'spec_helper'

describe CalendariumRomanum::Remote::Calendar do
  describe 'API-compatibility with Calendar'

  describe 'returns the same data as Calendar' do
    let(:year) { 2016 }

    # classical calendar
    let(:sanctorale) { CalendariumRomanum::Data::GENERAL_ROMAN_ENGLISH.load }
    let(:calendar) { CalendariumRomanum::Calendar.new(year, sanctorale) }

    # remote calendar with the same settings
    let(:uri) { REMOTE_CALENDAR_URI }
    let(:remote) { described_class.new(year, uri) }

    dates = [
      Date.new(2016, 12, 24),
    ]

    dates.each do |date|
      it date do
        c = calendar.day date
        r = remote.day date

        expect(r).to eq c
      end
    end
  end
end
