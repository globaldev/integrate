require 'bunny'
require 'integrate/options'
require 'integrate/channel_adapters/outbound/abstract_outbound_channel_adapter'

module Integrate
  module ChannelAdapters
    module Outbound
      class AMQP < AbstractOutboundChannelAdapter

        option :exchange, :exchange_name, default: ""
        option :key, :routing_key, required: true

        # options should be a hash, with the following available options:
        # [:exchange] the exchange to which messages will be published
        # [:key]      (required) the routing key for published messages
        #
        def initialize(options)
          super

          @client = Bunny.new
        end

        def call(message)
          super(message)
          output = message["payload"].to_s
          exchange.publish(output, key: @routing_key,
                                   content_type: message["content_type"])
        end

        def exchange
          return @exchange if @exchange

          @client.start
          @exchange = @client.exchange(@exchange_name)
        end

      end
    end
  end
end
