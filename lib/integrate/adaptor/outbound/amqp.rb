require 'bunny'

module Integrate
  module Adaptor
    module Outbound
      class AMQP
        
        # options should be a hash, with the following available options:
        # [:in]       (required) the input channel
        # [:exchange] the exchange to which messages will be published
        # [:key]      (required) the routing key for published messages
        #
        def initialize(options)
          options[:in].register(self)
          @exchange_name = options[:exchange] || ""
          @routing_key = options[:key]
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
