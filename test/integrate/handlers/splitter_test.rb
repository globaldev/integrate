require 'minitest/autorun'
require_relative '../../../lib/integrate/handlers/splitter'
require_relative '../../../lib/integrate/channel'

module Integrate
  class SplitterTest < MiniTest::Unit::TestCase

    def test_instantiation
      splitter = Splitter.new(in: Channel.new,
                              out: Channel.new)
      refute_nil(splitter)
    end

    def test_instantiation_with_block
      splitter = Splitter.new(in: Channel.new,
                              out: Channel.new) {}

      refute_nil(splitter)
    end

    def test_splits_correctly
      splitter = Splitter.new(in: Channel.new,
                              out: Channel.new) do |message|
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
