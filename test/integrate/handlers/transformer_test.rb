require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/transformer'
require_relative '../../../lib/integrate/channel'

module Integrate
  class TransformerTest < MiniTest::Unit::TestCase

    def test_instantiation
      transformer = Transformer.new(in: Channel.new)
      refute_nil(transformer)
    end

  end
end
