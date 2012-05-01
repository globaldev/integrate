require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/transformer'

module Integrate
  class TransformerTest < MiniTest::Unit::TestCase
    
    def test_instantiation
      transformer = Transformer.new
      refute_nil(transformer)
    end

  end
end
