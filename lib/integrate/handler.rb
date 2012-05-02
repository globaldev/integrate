module Integrate
  class Handler

    attr_reader :output_channel
    private :output_channel

    def initialize(output_channel=nil)
      @output_channel = output_channel
    end

    def call(message)
      output_channel.send(message) if output_channel
    end

  end
end
