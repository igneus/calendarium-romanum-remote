module CalendariumRomanum
  module Remote
    # Orchestrates retrieval and deserialization of calendar data
    # from a server accessed throught HTTP GET requests
    # and returning JSON responses.
    class Driver
      def initialize(uri_scheme, denormalizer)
        @uri_scheme = uri_scheme
        @denormalizer = denormalizer
      end

      def day(date)
        process :day, date
      end

      def year(year)
        process :year, year
      end

      protected

      def process(action, argument)
        uri = @uri_scheme.public_send action, argument
        response = request uri
        handle_errors response
        data = MultiJson.load response.body

        @denormalizer.public_send action, data
      end

      def request(uri)
        request = HTTPI::Request.new uri
        request.headers['Accept'] = 'application/json'
        request.headers['User-Agent'] =
          'calendarium-romanum-remote/' + Remote::VERSION

        HTTPI.get request
      end

      def handle_errors(response)
        if response.code != 200
          raise Error.new("Unexpected HTTP status #{response.code.inspect}")
        end
      end
    end
  end
end
