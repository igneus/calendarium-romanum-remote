require_relative 'spec_helper'

describe CalendariumRomanum::Remote::Calendar do
  CR = CalendariumRomanum

  describe 'API-compatibility with Calendar'

  describe 'returns the same data as Calendar' do
    let(:year) { 2016 }

    # classical calendar
    let(:sanctorale) { CR::Data::GENERAL_ROMAN_ENGLISH.load }
    let(:calendar) { CR::Calendar.new(year, sanctorale) }

    # remote calendar with the same settings
    let(:uri) { REMOTE_CALENDAR_URI }
    let(:remote) { described_class.new(year, uri) }

    days = (CR::Temporale::Dates.first_advent_sunday(2016) ... CR::Temporale::Dates.first_advent_sunday(2017))
      days.each do |date|
      it date do
        c = calendar.day date
        r = remote.day date

        expect(r).to eq c
      end
    end
  end
end
