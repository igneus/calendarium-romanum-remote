require_relative 'spec_helper'

describe CalendariumRomanum::Remote::Calendar do
  CR = CalendariumRomanum
  CRRemote = CalendariumRomanum::Remote

  let(:year) { 2016 }
  let(:uri) { REMOTE_CALENDAR_URI }
  let(:calendar) { described_class.new year, uri }

  describe '#year' do
    it 'returns the year passed to the constructor' do
      y = 2200
      cal = described_class.new y, uri
      expect(cal.year).to eq y
    end
  end

  describe '#lectionary' do
    it { expect(calendar.lectionary).to be :A }
  end

  describe '#ferial_lectionary' do
    it { expect(calendar.ferial_lectionary).to be 1 }
  end

  describe '#==' do
    describe 'same year and URI' do
      let(:c) { described_class.new year, uri }

      it 'is same' do
        expect(c == calendar).to be true
      end
    end

    describe 'year differs' do
      let(:c) { described_class.new year + 1, uri }

      it 'is different' do
        expect(c == calendar).to be false
      end
    end

    describe 'URI differs' do
      let(:c) { described_class.new year, 'http://other.uri' }

      it 'is different' do
        expect(c == calendar).to be false
      end
    end
  end

  describe 'API-compatibility with Calendar' do
    describe 'instance methods' do
      let(:year) { 2000 }

      let(:origin) { CR::Calendar.new(year) }
      let(:mirror) { CRRemote::Calendar.new(year, uri) }

      CR::Calendar.public_instance_methods.each do |method|
        describe method do
          it 'is defined by origin' do
            expect(origin).to respond_to method
          end

          it 'is defined by mirror' do
            expect(mirror).to respond_to method
          end

          it 'definitions match' do
            morig = origin.method method
            mmirr = mirror.method method

            expect(mmirr.arity).to eq morig.arity
            expect(mmirr.parameters).to eq morig.parameters
          end
        end
      end
    end
  end

  describe 'returns the same data as Calendar' do
    # classical calendar with the same settings as `calendar`
    let(:sanctorale) { CR::Data::GENERAL_ROMAN_ENGLISH.load }
    let(:local_calendar) { CR::Calendar.new(year, sanctorale) }

    let(:remote_calendar) { calendar }

    days = (CR::Temporale::Dates.first_advent_sunday(2016) ... CR::Temporale::Dates.first_advent_sunday(2017))
      days.each do |date|
      it date do
        c = local_calendar.day date
        r = remote_calendar.day date

        expect(r).to eq c
      end
    end
  end

  describe 'errors' do
    let(:date) { Date.new year, 1, 1 }

    describe 'server does not exist' do
      let(:uri) { 'http://does-not-exist.local/' }

      it 'throws SocketError' do
        expect do
          calendar.day date
        end.to raise_exception ::SocketError
      end
    end

    describe 'server exists, wrong calendar URI' do
      let(:wrong_calendar_uri) { uri + 'another-path-segment/' }
      let(:calendar) { described_class.new year, wrong_calendar_uri }

      it 'throws CalendariumRomanum::Remote::Error' do
        expect do
          calendar.day date
        end.to raise_exception CRRemote::Error, /Unexpected HTTP status 404/
      end
    end
  end
end
