require 'bunny'
require_relative '../../options'

module Integrate
  module ChannelAdapters
    module Outbound
      class AMQP
        extend Options

        option :id, public: true
        option :in, :input_channel, required: true
        option :exchange, :exchange_name, default: ""
        option :key, :routing_key, required: true

        # options should be a hash, with the following available options:
        # [:in]       (required) the input channel
        # [:exchange] the exchange to which messages will be published
        # [:key]      (required) the routing key for published messages
        #
        def initialize(options)
          super

          input_channel.register(self)

          @client = Bunny.new
        end

        def call(message)
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
