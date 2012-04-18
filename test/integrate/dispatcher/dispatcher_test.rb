require 'minitest/autorun'
require_relative '../../../lib/integrate/dispatcher/dispatcher'

module Integrate
  class DispatcherTest < MiniTest::Unit::TestCase
    def test_instantiation
      dispatcher = Dispatcher.new
      refute_nil(dispatcher)
    end
    
    def test_register_message_handler
      dispatcher = Dispatcher.new
      dummy_handler = DummyMessageHandler.new
      dispatcher.register_handler(dummy_handler)
      assert_equal({dummy_handler.hash => dummy_handler}, dispatcher.handlers)
    end
    
    def test_remove_message_handler
      dispatcher = Dispatcher.new
      handler_one = DummyMessageHandler.new
      handler_two = DummyMessageHandler.new
      
      dispatcher.register_handler(handler_one)
      dispatcher.register_handler(handler_two)
      
      assert_equal({handler_one.hash => handler_one, handler_two.hash => handler_two}, dispatcher.handlers)
      
      dispatcher.unregister_handler(handler_one)
      assert_equal({handler_two.hash => handler_two}, dispatcher.handlers)
      
    end
    
    class DummyMessageHandler
    end
    
  end
end