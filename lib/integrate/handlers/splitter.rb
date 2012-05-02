require_relative '../handler'

module Integrate
  class Splitter < Handler

    def call(message)
      split.each { super(message) }
    end

    # Returns an Array of messages
    def split(message)
    end

  end
end
