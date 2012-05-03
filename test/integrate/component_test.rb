require 'minitest/autorun'

module Integrate
  class ComponentTest < MiniTest::Unit::TestCase

    def test_id_generated
      component = Component.new
      refute_nil(component.id)
    end
    
    def test_generated_ids_different
      first = Component.new
      second = Component.new
      assert_equal(false, first.id == second.id)
    end
    
    def test_subclasses_receive_sensible_name
      child = SubComponent.new
      assert_equal(true, !child.id.match(/SubComponent/).nil?)
    end
    
    class SubComponent < Component; end

  end
end
