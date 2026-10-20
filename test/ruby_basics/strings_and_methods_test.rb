require "test_helper"

# Section 4.2 — every console example from the manual, written as assertions.
class StringsAndMethodsTest < ActiveSupport::TestCase
  # 4.2.1 Comments
  test "4.2.1 comments are ignored" do
    assert_equal 59, 17 + 42 # Сложение целых чисел
  end

  # 4.2.2 Strings
  test "4.2.2 string literals and concatenation" do
    assert_equal "", ""
    assert_equal "foo", "foo"
    assert_equal "foobar", "foo" + "bar"
  end

  test "4.2.2 interpolation" do
    first_name = "Michael"
    last_name  = "Hartl"
    assert_equal "Michael Hartl", "#{first_name} Hartl"
    assert_equal "Michael Hartl", first_name + " " + last_name
    assert_equal "Michael Hartl", "#{first_name} #{last_name}"
  end

  test "4.2.2 puts and print" do
    assert_output("foo\n") { assert_nil puts("foo") }
    assert_output("foo")   { assert_nil print("foo") }
    assert_output("foo\n") { print "foo\n" }
  end

  test "4.2.2 single-quoted strings are literal" do
    assert_equal "foo", 'foo'
    assert_equal "foobar", 'foo' + 'bar'
    assert_equal "\#{foo} bar", '#{foo} bar'
    assert_equal "\\n", '\n'
    assert_equal "Новые строки (\\n) и табуляция (\\t) используют символ бэкслэш \\.",
                 'Новые строки (\n) и табуляция (\t) используют символ бэкслэш \.'
  end

  # 4.2.3 Objects and message passing
  test "4.2.3 strings respond to length and empty?" do
    assert_equal 6, "foobar".length
    assert_equal false, "foobar".empty?
    assert_equal true, "".empty?
  end

  test "4.2.3 if / elsif / else" do
    s = "foobar"
    result = if s.empty?
               "The string is empty"
             else
               "The string is nonempty"
             end
    assert_equal "The string is nonempty", result

    result = if s.nil?
               "The variable is nil"
             elsif s.empty?
               "The string is empty"
             elsif s.include?("foo")
               "The string includes 'foo'"
             end
    assert_equal "The string includes 'foo'", result
  end

  test "4.2.3 && || ! and trailing if / unless" do
    x = "foo"
    y = ""
    assert_output("") { puts "Both strings are empty" if x.empty? && y.empty? }
    assert_output("One of the strings is empty\n") { puts "One of the strings is empty" if x.empty? || y.empty? }
    assert_output("x is not empty\n") { puts "x is not empty" if !x.empty? }

    string = "foobar"
    assert_output("The string 'foobar' is nonempty.\n") do
      puts "The string '#{string}' is nonempty." unless string.empty?
    end
  end

  test "4.2.3 nil is an object too" do
    assert_equal "", nil.to_s
    error = assert_raises(NoMethodError) { nil.empty? }
    assert_match "empty?", error.message
    assert_equal true, nil.to_s.empty?
    assert_equal false, "foo".nil?
    assert_equal false, "".nil?
    assert_equal true, nil.nil?
  end

  test "4.2.3 only nil and false are falsy" do
    assert_equal false, !!nil
    assert_equal true, !!0
  end

  # 4.2.4 Method definitions
  def string_message(str = "")
    if str.empty?
      "It's an empty string!"
    else
      "The string is nonempty."
    end
  end

  def string_message_with_return(str = "")
    return "It's an empty string!" if str.empty?
    return "The string is nonempty."
  end

  def string_message_renamed(the_function_argument = "")
    if the_function_argument.empty?
      "It's an empty string!"
    else
      "The string is nonempty."
    end
  end

  test "4.2.4 method with default argument and implicit return" do
    assert_equal "The string is nonempty.", string_message("foobar")
    assert_equal "It's an empty string!", string_message("")
    assert_equal "It's an empty string!", string_message
  end

  test "4.2.4 explicit return and argument name do not change behaviour" do
    %w[foobar].push("").each do |arg|
      assert_equal string_message(arg), string_message_with_return(arg)
      assert_equal string_message(arg), string_message_renamed(arg)
    end
  end

  # 4.2.5 Back to the title helper
  test "4.2.5 full_title helper" do
    helper = Object.new.extend(ApplicationHelper)
    assert_equal "Ruby on Rails Tutorial Sample App", helper.full_title
    assert_equal "Help | Ruby on Rails Tutorial Sample App", helper.full_title("Help")
  end
end
