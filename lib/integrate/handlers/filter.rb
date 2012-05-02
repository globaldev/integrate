require_relative '../handler'

module Integrate
  class Filter < Handler

    def call(message)
      super(message) if allow?(message)
    end

    def allow?(message)
    end

  end
end
