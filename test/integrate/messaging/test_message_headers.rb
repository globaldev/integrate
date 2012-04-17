require 'minitest/autorun'
require_relative '../../../lib/integrate/messaging/message_headers'

module Integrate
  class TestMessageHeaders < MiniTest::Unit::TestCase
    def test_instantiation
      message_headers = MessageHeaders.new({"header_one" => "value_one"})
      refute_nil(message_headers)
      assert_equal({"header_one" => "value_one"}, message_headers.headers)
    end
    
    def test_only_string_headers_allowed  
      assert_raises(ArgumentError) do
        message_headers = MessageHeaders.new({4 => "value_one"})
      end
    end
  end
end
