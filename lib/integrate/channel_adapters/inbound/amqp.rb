require 'bunny'
require 'integrate/options'
require 'integrate/channel_adapters/inbound/abstract_inbound_channel_adapter'

module Integrate
  module ChannelAdapters
    module Inbound
      class AMQP < AbstractInboundChannelAdapter

        option :queue, :queue_name, required: true

        # options should be a hash, with the following available options:
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
            call(message)
          end
        end

      end
    end
  end
end
