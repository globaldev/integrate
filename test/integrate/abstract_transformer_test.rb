require_relative '../helper'

require 'integrate/abstract_transformer'
require 'integrate/channel'

module Integrate
  class AbstractTransformerTest < MiniTest::Unit::TestCase

    class DummyTransformer < AbstractTransformer ; end

    def test_instantiation
      transformer = DummyTransformer.new(in: Channel.new,
                                         out: Channel.new)
      refute_nil(transformer)
    end

    def test_instantiation_with_block
      transformer = DummyTransformer.new(in: Channel.new,
                                         out: Channel.new) {}

      refute_nil(transformer)
    end

    def test_transforms_correctly
      transformer = DummyTransformer.new(in: Channel.new,
                                         out: Channel.new) do |message|
        message["payload"] = message["payload"].reverse
        message
      end

      assert_equal({"payload" => "foo"}, transformer.transform({"payload" => "oof"}))
    end

  end
end
