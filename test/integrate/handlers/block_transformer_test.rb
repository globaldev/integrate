require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/block_transformer'
require_relative '../../../lib/integrate/channel'

module Integrate
  class BlockTransformerTest < MiniTest::Unit::TestCase

    def test_instantiate_without_block
      assert_raises(ArgumentError) do
        transformer = BlockTransformer.new(in: Channel.new)
      end
    end
    
    def test_instantiation
      transformer = BlockTransformer.new(in: Channel.new) {}
      
      refute_nil(transformer)
    end
    
    def test_transforms_correctly
      transformer = BlockTransformer.new(in: Channel.new) do |message|
        message["payload"] = message["payload"].reverse
        message
      end
      
      assert_equal({"payload" => "foo"}, transformer.transform({"payload" => "oof"}))
    end

  end
end
