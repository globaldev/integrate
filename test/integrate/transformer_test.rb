require_relative '../helper'

require 'integrate/transformer'
require 'integrate/channel'

module Integrate
  class TransformerTest < MiniTest::Unit::TestCase

    def test_instantiation
      transformer = Transformer.new(in: Channel.new,
                                    out: Channel.new)
      refute_nil(transformer)
    end

    def test_instantiation_with_block
      transformer = Transformer.new(in: Channel.new,
                                    out: Channel.new) {}

      refute_nil(transformer)
    end

    def test_transforms_correctly
      transformer = Transformer.new(in: Channel.new,
                                    out: Channel.new) do |message|
        message["payload"] = message["payload"].reverse
        message
      end

      assert_equal({"payload" => "foo"}, transformer.transform({"payload" => "oof"}))
    end

  end
end
