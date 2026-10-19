require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  BASE_TITLE = "Ruby on Rails Tutorial Sample App"

  test "full_title without page title returns base title" do
    assert_equal BASE_TITLE, full_title
    assert_equal BASE_TITLE, full_title("")
  end

  test "full_title prepends page title with separator" do
    assert_equal "Help | #{BASE_TITLE}", full_title("Help")
  end
end
