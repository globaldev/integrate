require_relative '../handler'

module Integrate

  # A splitter is a message handler that generates multiple downstream messages
  # from a single input message.
  #
  # The Splitter class is available as a superclass for any kind of splitter,
  # simply subclass and override the #split method.
  #
  # Splitter may be used without subclassing by supplying a block to ::new,
  # the block will then be invoked to perform the message splitting.
  #
  class Splitter < Handler

    def initialize(options, &block)
      super
      @block = block if block
    end

    def call(message)
      split.each { super(message) }
    end

    # Returns an Array of messages
    def split(message)
      @block.call(message) if @block
    end

  end
end
