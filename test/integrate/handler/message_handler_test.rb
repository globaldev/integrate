require 'minitest/autorun'
require_relative '../../../lib/integrate/handler/message_handler'
require_relative '../../../lib/integrate/transformer/transformer'

module Integrate
  class MessageHandlerTest < MiniTest::Unit::TestCase
    
    def test_reply_sent_if_output_channel
      transformer = PayloadUpcasingTransformer.new

      input_channel = Channel.new
      input_channel.subscribe(transformer)
      
      output_channel = MiniTest::Mock.new
      output_channel.expect :send, true, [Message]
      
      transformer.output_channel = output_channel
      
      incoming_message = MessageBuilder.with_payload("test").build
      input_channel.send(incoming_message)
      
      output_channel.verify
    end
    
    class PayloadUpcasingTransformer < Transformer
      def transform(message)
        MessageBuilder.with_payload(message.payload.upcase).build
      end
    end
    
  end
end
