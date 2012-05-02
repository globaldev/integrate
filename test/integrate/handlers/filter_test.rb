require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/filter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class FilterTest < MiniTest::Unit::TestCase

    def test_instantiation
      filter = Filter.new(in: Channel.new)
      refute_nil(filter)
    end

  end
end
