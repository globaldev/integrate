require_relative '../helper'

require 'set'
require 'integrate/channel'

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

    def test_register
      subscribing_handler = MiniTest::Mock.new
      subscribing_handler.expect :hash, 3735928559

      dispatcher = @channel.dispatcher

      @channel.register(subscribing_handler)
      assert_equal(Set[subscribing_handler], dispatcher.handlers)
    end

    def test_send
      message = { "payload" => "test" }

      handler = MiniTest::Mock.new
      handler.expect :hash, 3735928559
      handler.expect :call, true, [message]

      @channel.register(handler)
      @channel.send(message)

      handler.verify
    end

    def test_unregister
      subscribing_handler = MiniTest::Mock.new
      subscribing_handler.expect :hash, 3735928559

      dispatcher = @channel.dispatcher

      @channel.register(subscribing_handler)
      assert_equal(Set[subscribing_handler], dispatcher.handlers)

      @channel.unregister(subscribing_handler)
      assert_equal(Set[], dispatcher.handlers)
    end
  end
end
