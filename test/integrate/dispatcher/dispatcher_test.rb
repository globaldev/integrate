require 'minitest/autorun'
require 'set'
require_relative '../../../lib/integrate/dispatcher/dispatcher'
require_relative '../../../lib/integrate/messaging/message_builder'

module Integrate
  class DispatcherTest < MiniTest::Unit::TestCase
    
    attr_accessor :dispatcher
    
    def setup
      @dispatcher = Dispatcher.new
    end

    def teardown
      @dispatcher = nil
    end
    
    def test_instantiation
      refute_nil(dispatcher)
    end
    
    def test_register_message_handler
      dispatcher = Dispatcher.new
      dummy_handler = DummyMessageHandler.new
      dispatcher.register_handler(dummy_handler)
      assert_equal(Set[dummy_handler], dispatcher.handlers)
    end
    
    def test_remove_message_handler
      dispatcher = Dispatcher.new
      handler_one = DummyMessageHandler.new
      handler_two = DummyMessageHandler.new
      
      dispatcher.register_handler(handler_one)
      dispatcher.register_handler(handler_two)
      
      assert_equal(Set[handler_one, handler_two], dispatcher.handlers)
      
      dispatcher.unregister_handler(handler_one)
      assert_equal(Set[handler_two], dispatcher.handlers)
    end
    
    class DummyMessageHandler
      def call(message)
      end
    end
    
    def test_successful_dispatch
      dispatcher = Dispatcher.new
      test_message = MessageBuilder.with_payload("test").build
      
      handler_one = MiniTest::Mock.new
      handler_one.expect :hash, 3735928559
      handler_one.expect :call, true, [test_message]
      
      dispatcher.register_handler(handler_one)
      
      assert_equal(true, dispatcher.call(test_message))
      
      handler_one.verify
    end
    
    def test_error_dispatch
      dispatcher = Dispatcher.new
      test_message = MessageBuilder.with_payload("test")
      
      assert_raises(StandardError) do
        dispatcher.call(test_message)
      end
    end
  end
end