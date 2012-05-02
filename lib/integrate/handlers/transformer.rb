require_relative '../handler'

module Integrate

  # A transformer is a message handler that modifies the message it handles.
  #
  # The Transformer class is available as a superclass for any kind of
  # transformer, simply subclass and override the #transform method.
  #
  # Transformer may be used without subclassing by supplying a block to ::new,
  # the block will then be invoked to perform the message transformation.
  #
  class Transformer < Handler

    # options should be a hash, with the following available options:
    # [:in]  (required) the input channel
    # [:out] (required) the output channel
    #
    def initialize(options, &block)
      raise ArgumentError, "Transformer requires an output channel" unless options[:out]
      super
      @block = block if block
    end

    def call(message)
      result = transform(message)
      super(result)
    end

    def transform(message)
      @block.call(message.dup)
    end

  end
end
