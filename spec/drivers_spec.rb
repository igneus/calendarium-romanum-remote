require 'spec_helper'

describe CalendariumRomanum::Remote::Drivers do
  CRRem = CalendariumRomanum::Remote

  shared_examples 'any driver' do
    let(:base_uri) { REMOTE_CALENDAR_URI }
    let(:date) { Date.new 2000, 1, 1 }

    describe 'success' do
      it 'returns a string' do
        r = driver.get date, base_uri
        expect(r).to be_a String
        expect(r).not_to be_empty
      end

      it 'returns a valid JSON' do
        r = driver.get date, base_uri
        expect do
          JSON.parse(r)
        end.not_to raise_exception
      end
    end

    describe 'server not found' do
      let(:base_uri) { 'http://unknown.server.xyz' }

      it 'fails' do
        expect do
          driver.get date, base_uri
        end.to raise_exception CRRem::ServerNotFoundError
      end
    end

    describe 'connection refused' do
      let(:base_uri) { 'http://localhost:33333' }

      it 'fails' do
        expect do
          driver.get date, base_uri
        end.to raise_exception CRRem::ServerNotFoundError
      end
    end

    describe 'calendar not found' do
      let(:base_uri) { REMOTE_CALENDAR_URI.sub(/(?<=calendars\/).*$/, 'unknown-calendar') }

      it 'fails' do
        expect do
          driver.get date, base_uri
        end.to raise_exception CRRem::BadRequestError
      end
    end

    describe 'invalid date' do
      # this won't ever happen, but the driver must be prepared
      # to handle bad request scenarios
      let(:date) { double(year: 2000, month: 13, day: 40) }

      it 'fails' do
        expect do
          driver.get date, base_uri
        end.to raise_exception CRRem::BadRequestError
      end
    end
  end

  describe CalendariumRomanum::Remote::Drivers::NetHttpDriver do
    let(:driver) { described_class.new }

    it_behaves_like 'any driver'

    # implementation-specific error handling
    describe 'network error'
  end
end
