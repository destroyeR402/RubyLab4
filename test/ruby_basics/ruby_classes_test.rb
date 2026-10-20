require "test_helper"

# Section 4.4 — constructors, inheritance, reopening classes, controllers, User.
class RubyClassesTest < ActiveSupport::TestCase
  # First version of Word from 4.4.2: a plain class with a palindrome? method.
  class PlainWord
    def palindrome?(string)
      string == string.reverse
    end
  end

  # Listing 4.12: Word inherits from String.
  class Word < String
    # Returns true if the word is a palindrome.
    def palindrome?
      self == self.reverse
    end
  end

  # 4.4.1 Constructors
  test "4.4.1 literal and named constructors" do
    s = "foobar"
    assert_equal String, s.class
    s = String.new("foobar")
    assert_equal String, s.class
    assert s == "foobar"
    assert_equal [1, 3, 2], Array.new([1, 3, 2])
  end

  test "4.4.1 Hash.new takes a default value" do
    h = Hash.new
    assert_nil h[:foo]
    h = Hash.new(0)
    assert_equal 0, h[:foo]
  end

  # 4.4.2 Class inheritance
  test "4.4.2 String inheritance hierarchy" do
    s = String.new("foobar")
    assert_equal String, s.class
    assert_equal Object, s.class.superclass
    assert_equal BasicObject, s.class.superclass.superclass
    assert_nil s.class.superclass.superclass.superclass
  end

  test "4.4.2 plain Word class" do
    w = PlainWord.new
    assert_equal false, w.palindrome?("foobar")
    assert_equal true, w.palindrome?("level")
  end

  test "4.4.2 Word inherits from String" do
    s = Word.new("level")
    assert_equal "level", s
    assert s.palindrome?
    assert_equal 5, s.length
    assert_equal Word, s.class
    assert_equal String, s.class.superclass
    assert_equal Object, s.class.superclass.superclass
  end

  # 4.4.3 Modifying built-in classes
  # String#palindrome? is added in config/initializers/string_extensions.rb,
  # so in this app it is already available on any string literal.
  test "4.4.3 reopened String class" do
    assert "deified".palindrome?
    assert_not "foobar".palindrome?
  end

  test "4.4.3 Rails adds blank? to Object" do
    assert "".blank?
    assert_not "    ".empty?
    assert "    ".blank?
    assert nil.blank?
  end

  # 4.4.4 A controller class
  test "4.4.4 StaticPagesController hierarchy" do
    controller = StaticPagesController.new
    assert_equal StaticPagesController, controller.class
    assert_equal [
      ApplicationController,
      ActionController::Base,
      ActionController::Metal,
      AbstractController::Base,
      Object
    ], 5.times.each_with_object([controller.class]) { |_, chain| chain << chain.last.superclass }.drop(1)
    assert_nil controller.home
  end

  # 4.4.5 A user class (lib/example_user.rb)
  test "4.4.5 example user from the console session" do
    example = ExampleUser.new
    assert_nil example.name
    example.name  = "Example User"
    example.email = "user@example.com"
    assert_equal "Example User <user@example.com>", example.formatted_email

    user = ExampleUser.new(name: "Michael Hartl", email: "mhartl@example.com")
    assert_equal "Michael Hartl <mhartl@example.com>", user.formatted_email
  end
end
