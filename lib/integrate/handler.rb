require_relative 'component'

module Integrate
  class Handler < Component

    attr_reader :output_channel
    private :output_channel

    # options should be a hash, with the following available options:
    # [:in]  (required) the input channel
    # [:out] the output channel
    #
    def initialize(options)
      super(options)
      @output_channel = options[:out]
      options[:in].register(self)
    end

    def call(message)
      output_channel.send(message) if output_channel
    end

  end
end
