require 'minitest/autorun'
require_relative '../../../lib/integrate/messaging/message_builder'

module Integrate
  class MessageBuilderTest < MiniTest::Unit::TestCase
    def test_build_with_headers  
      message = MessageBuilder.from_headers({"header_one" => "value_one"}).build
      refute_nil(message)
      assert_equal(Message, message.class)
      assert_equal({"header_one" => "value_one"}, message.headers)
    end
    
    def test_build_from_payload
      payload = "TestPayload"
      message = MessageBuilder.with_payload(payload).build
      refute_nil(message)
      assert_equal(Message, message.class)
      assert_equal(payload, message.payload)
    end
    
    def test_build_from_payload_copy_headers
      payload = "TestPayload"
      message_one = MessageBuilder.from_headers({"key" => "value", "foo" => "bar"}).build
      message_two = MessageBuilder.with_payload(payload).copy_headers(message_one).build
      refute_nil(message_two)
      assert(message_two.is_a?(Message))
      assert_equal(payload, message_two.payload)
      assert_equal({"key" => "value", "foo" => "bar"}, message_two.headers)
    end
  end
end