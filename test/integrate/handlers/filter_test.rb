require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/filter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class FilterTest < MiniTest::Unit::TestCase

    def test_instantiation
      filter = Filter.new(in: Channel.new, out: Channel.new)
      refute_nil(filter)
    end

    def test_instantiation_with_block
      filter = Filter.new(in: Channel.new, out: Channel.new) {}

      refute_nil(filter)
    end

    def test_filters_correctly
      filter = Filter.new(in: Channel.new, out: Channel.new) do |message|
        message["payload"] == "TesT"
      end

      assert_equal(true, filter.allow?({"payload" => "TesT"}))
      assert_equal(false, filter.allow?({"payload" => "test"}))
    end

  end
end
