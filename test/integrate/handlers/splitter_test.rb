require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/splitter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class SplitterTest < MiniTest::Unit::TestCase

    def test_instantiation
      splitter = Splitter.new(in: Channel.new)
      refute_nil(splitter)
    end

  end
end
