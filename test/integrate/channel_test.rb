require 'minitest/autorun'
require 'set'
require_relative '../../lib/integrate/channel'

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
      subscribing_handler.expect :hash, 3735928559
      
      dispatcher = @channel.dispatcher
      
      @channel.subscribe(subscribing_handler)
      assert_equal(Set[subscribing_handler], dispatcher.handlers)
    end
    
    def test_send
      message = {"payload" => "test"}
      
      handler = MiniTest::Mock.new
      handler.expect :hash, 3735928559
      handler.expect :call, true, [message]
      
      @channel.subscribe(handler)
      @channel.send(message)
      
      handler.verify
    end
    
    def test_unsubscribe
      subscribing_handler = MiniTest::Mock.new
      subscribing_handler.expect :hash, 3735928559
      
      dispatcher = @channel.dispatcher
      
      @channel.subscribe(subscribing_handler)
      assert_equal(Set[subscribing_handler], dispatcher.handlers)
      @channel.unsubscribe(subscribing_handler)
      assert_equal(Set[], dispatcher.handlers)
    end
  end
end
