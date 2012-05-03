require 'bunny'

module Integrate
  module Adapters
    module Inbound
      class AMQP

        # options should be a hash, with the following available options:
        # [:out]   (required) the output channel
        # [:queue] (required) the AMQP queue to subscribe to
        #
        def initialize(options)
          @output_channel = options[:out]
          @queue_name = options[:queue]
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
