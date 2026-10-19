require "test_helper"

class ExampleUserTest < ActiveSupport::TestCase
  test "attributes default to nil" do
    user = ExampleUser.new
    assert_nil user.name
    assert_nil user.email
  end

  test "attributes can be assigned through accessors" do
    user = ExampleUser.new
    user.name  = "Example User"
    user.email = "user@example.com"
    assert_equal "Example User <user@example.com>", user.formatted_email
  end

  test "initialize accepts an attributes hash" do
    user = ExampleUser.new(name: "Michael Hartl", email: "mhartl@example.com")
    assert_equal "Michael Hartl <mhartl@example.com>", user.formatted_email
  end
end
