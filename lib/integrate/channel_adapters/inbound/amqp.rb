require 'bunny'
require_relative '../../options'

module Integrate
  module ChannelAdapters
    module Inbound
      class AMQP
        extend Options

        option :id, public: true
        option :out, :output_channel, required: true
        option :queue, :queue_name, required: true

        # options should be a hash, with the following available options:
        # [:out]   (required) the output channel
        # [:queue] (required) the AMQP queue to subscribe to
        #
        def initialize(options)
          super

          @client = Bunny.new
        end

        def start
          @client.start
          queue = @client.queue(@queue_name)
          queue.subscribe do |msg|
            message = {}
            message["payload"] = msg[:payload]
            @output_channel.send(message)
          end
        end

      end
    end
  end
end
