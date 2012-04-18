require 'minitest/autorun'
require_relative '../../../lib/integrate/dispatcher/dispatcher'

module Integrate
  class DispatcherTest < MiniTest::Unit::TestCase
    def test_instantiation
      dispatcher = Dispatcher.new
      refute_nil(dispatcher)
    end
  end
end