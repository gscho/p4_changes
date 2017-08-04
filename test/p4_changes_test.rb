require "test_helper"

class P4ChangesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::P4Changes::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
