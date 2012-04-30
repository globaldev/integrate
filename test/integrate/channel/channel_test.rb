require 'minitest/autorun'
require_relative '../../../lib/integrate/channel/channel'

module Integrate
  class ChannelTest < MiniTest::Unit::TestCase
    
    attr_accessor :dispatcher
    
    def setup
      @channel = Channel.new
    end
    
    def teardown
      @channel = nil
    end
    
    def test_instantiation
      refute_nil(@channel)
    end
    
    def test_subscribe
      subscribing_handler = MiniTest::Mock.new
      subscribing_handler.expect :hash, "one"
      subscribing_handler.expect :call, true, [message]
      
      dispatcher = @channel.dispatcher
      
      @channel.subscribe(subscribing_handler)
      assert_equal({"one" => subscribing_handler}, dispatcher.handlers)
    end
    
    def test_send
      message = MessageBuilder.with_payload("test")
      
      handler = MiniTest::Mock.new
      handler.expect :hash, "hash"
      handler.expect :call, true, [message]
      
      @channel.subscribe(handler)
      @channel.send(message)
      
      handler.verify
    end
    
    def test_subscribe
      subscribing_handler = MiniTest::Mock.new
      subscribing_handler.expect :hash, "one"
      subscribing_handler.expect :call, true, [message]
      
      dispatcher = @channel.dispatcher
      
      @channel.subscribe(subscribing_handler)
      assert_equal({"one" => subscribing_handler}, dispatcher.handlers)
      @channel.unsubscribe(subscribing_handler)
      assert_equal({}, dispatcher.handlers)
    end
  end
end
