require 'minitest/autorun'
require_relative '../../../lib/integrate/transformer/transformer'
require_relative '../../../lib/integrate/channel/channel'

module Integrate
  class MessageHandlerTest < MiniTest::Unit::TestCase
    
    def test_reply_sent_if_output_channel
      incoming_message = {"payload" => "test"}
      
      output_channel = MiniTest::Mock.new
      output_channel.expect :send, true, [incoming_message]
      
      transformer = PayloadUpcasingTransformer.new(output_channel)
      
      input_channel = Channel.new
      input_channel.subscribe(transformer)
      
      input_channel.send(incoming_message)
      
      output_channel.verify
    end
    
    class PayloadUpcasingTransformer < Transformer
      def transform(message)
        message.dup.tap do |copy|
          copy["payload"] = message["payload"]
        end
      end
    end
    
  end
end
