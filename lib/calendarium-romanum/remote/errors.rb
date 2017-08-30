module CalendariumRomanum
  module Remote
    # parent of the gem's error classes,
    # never itself instantiated
    class Error < ::RuntimeError; end

    # server not found
    class ServerNotFoundError < Error; end

    # server refuses submitted input
    class BadRequestError < Error; end

    class TransportError < Error; end
  end
end
