require "test_helper"

class P4ChangesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::P4Changes::VERSION
  end

  def test_that_format_succeeded
    p4 = ::P4Changes::P4::new('', '#head', '//FAKE')
    assert_equal '', p4.from
    assert_equal '#head', p4.to
    p4 = ::P4Changes::P4::new('12345', '54321', '//FAKE')
    assert_equal '@12345,', p4.from
    assert_equal '@54321', p4.to
  end

  def test_fake_depot_returns_empty_arr
    p4 = ::P4Changes::P4::new('', '#head', '//FAKE')
    assert_equal [], p4.get_changelists()
  end
end
