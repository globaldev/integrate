require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/block_splitter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class BlockSplitterTest < MiniTest::Unit::TestCase

    def test_instantiate_without_block
      assert_raises(ArgumentError) do
        splitter = BlockSplitter.new(in: Channel.new)
      end
    end
    
    def test_instantiation
      splitter = BlockSplitter.new(in: Channel.new) {}
      
      refute_nil(splitter)
    end
    
    def test_splits_correctly
      splitter = BlockSplitter.new(in: Channel.new) do |message|
        
        message["items"].each_with_object([]) do |item_id, result|
          result << {"item_id" => item_id}
        end
      end
      
      in_message = {"items" => [1,5,54]}
      
      assert_equal([{"item_id" => 1},
                    {"item_id" => 5},
                    {"item_id" => 54}], splitter.split(in_message))
    end

  end
end
