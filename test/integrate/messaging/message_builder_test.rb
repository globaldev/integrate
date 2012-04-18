require 'minitest/autorun'
require_relative '../../../lib/integrate/messaging/message_builder'

module Integrate
  class MessageBuilderTest < MiniTest::Unit::TestCase
    def test_build_with_headers
      message = MessageBuilder.from_headers({"header_one" => "value_one"})
      refute_nil(message)
      assert_equal({"header_one" => "value_one"}, message.headers)
    end
    
    def test_build_from_payload
      payload = "TestPayload"
      message = MessageBuilder.with_payload(payload)
      refute_nil(message)
      assert_equal(payload, message.payload)
    end
  end
end