module CalendariumRomanum
  module Remote
    # parent of the gem's error classes,
    # never itself instantiated
    class Error < ::RuntimeError; end

    # the server responded with a response which cannot be
    # transformed to valid calendar data
    class UnexpectedResponseError < Error; end

    # the server returned data which we don't understand
    class InvalidDataError < Error; end
  end
end
