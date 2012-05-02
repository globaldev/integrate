require 'minitest/autorun'
require_relative '../../lib/integrate/handlers/transformer'
require_relative '../../lib/integrate/channel'

module Integrate
  class HandlerTest < MiniTest::Unit::TestCase

    def test_reply_sent_if_output_channel
      incoming_message = {"payload" => "test"}

      output_channel = MiniTest::Mock.new
      output_channel.expect :send, true, [incoming_message]
      input_channel = Channel.new

      transformer = PayloadUpcasingTransformer.new(in: input_channel, out: output_channel)

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
