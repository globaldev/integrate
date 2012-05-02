require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/block_filter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class BlockFilterTest < MiniTest::Unit::TestCase

    def test_instantiate_without_block
      assert_raises(ArgumentError) do
        filter = BlockFilter.new(in: Channel.new)
      end
    end
    
    def test_instantiation
      filter = BlockFilter.new(in: Channel.new) {}
      
      refute_nil(filter)
    end
    
    def test_filters_correctly
      filter = BlockFilter.new(in: Channel.new) do |message|
        message["payload"] == "TesT"
      end
      
      assert_equal(true, filter.allow?({"payload" => "TesT"}))
      assert_equal(false, filter.allow?({"payload" => "test"}))
    end

  end
end
