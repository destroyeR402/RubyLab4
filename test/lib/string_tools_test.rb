require "test_helper"

class StringToolsTest < ActiveSupport::TestCase
  test "string_shuffle keeps the same letters" do
    shuffled = StringTools.string_shuffle("foobar")
    assert_equal "foobar".chars.sort, shuffled.chars.sort
  end

  test "String#shuffle keeps the same letters" do
    assert_equal "foobar".chars.sort, "foobar".shuffle.chars.sort
    assert_equal "", "".shuffle
  end

  test "String#palindrome?" do
    assert "level".palindrome?
    assert "deified".palindrome?
    assert_not "foobar".palindrome?
  end
end
