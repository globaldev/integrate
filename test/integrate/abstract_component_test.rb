require_relative '../helper'

require 'integrate/abstract_component'

module Integrate
  class AbstractComponentTest < MiniTest::Unit::TestCase

    def test_id_generated
      component = AbstractComponent.new

      refute_nil(component.id)
    end

    def test_generated_ids_different
      first  = AbstractComponent.new
      second = AbstractComponent.new

      assert_equal(false, first.id == second.id)
    end

    def test_subclasses_receive_sensible_name
      child = SubComponent.new

      assert_equal(true, !child.id.match(/SubComponent/).nil?)
    end

    class SubComponent < AbstractComponent; end

  end
end
