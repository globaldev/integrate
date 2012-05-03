require_relative 'component'

module Integrate
  class Handler < Component

    option :in, :input_channel, required: true
    option :out, :output_channel

    # options should be a hash, with the following available options:
    # [:in]  (required) the input channel
    # [:out] the output channel
    #
    def initialize(options, &block)
      super
      input_channel.register(self)
      @block = block if block
    end

    def call(message)
      output_channel.send(message) if output_channel
    end

  end
end
