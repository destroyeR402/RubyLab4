require "test_helper"

# Section 4.3 — arrays, ranges, blocks, hashes and symbols.
class DataStructuresTest < ActiveSupport::TestCase
  # 4.3.1 Arrays and ranges
  test "4.3.1 split turns a string into an array" do
    assert_equal %w[foo bar baz], "foo bar     baz".split
    assert_equal %w[foo bar baz], "fooxbarxbazx".split("x")
  end

  test "4.3.1 array indexing" do
    a = [42, 8, 17]
    assert_equal 42, a[0]
    assert_equal 8, a[1]
    assert_equal 17, a[2]
    assert_equal 17, a[-1]
    assert_equal 42, a.first
    assert_equal 8, a.second # added by Rails
    assert_equal 17, a.last
    assert a.last == a[-1]
  end

  test "4.3.1 comparison operators" do
    x = [42, 8, 17].length
    assert_equal 3, x
    assert x == 3
    assert_not x == 1
    assert x != 1
    assert x >= 1
    assert_not x < 1
  end

  test "4.3.1 array methods do not change the array, bang methods do" do
    a = [42, 8, 17]
    assert_not a.empty?
    assert a.include?(42)
    assert_equal [8, 17, 42], a.sort
    assert_equal [17, 8, 42], a.reverse
    assert_equal a.sort, a.shuffle.sort
    assert_equal [42, 8, 17], a
    assert_equal [8, 17, 42], a.sort!
    assert_equal [8, 17, 42], a
  end

  test "4.3.1 push, << and join" do
    a = [42, 8, 17]
    assert_equal [42, 8, 17, 6], a.push(6)
    assert_equal [42, 8, 17, 6, 7], a << 7
    assert_equal [42, 8, 17, 6, 7, "foo", "bar"], a << "foo" << "bar"
    assert_equal "4281767foobar", a.join
    assert_equal "42, 8, 17, 6, 7, foo, bar", a.join(", ")
  end

  test "4.3.1 ranges" do
    assert_equal (0..9), 0..9
    assert_raises(NoMethodError) { 9.to_a } # 0..9.to_a calls to_a on 9
    assert_equal [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], (0..9).to_a
    a = %w[foo bar baz quux]
    assert_equal %w[foo bar baz], a[0..2]
    a = (0..9).to_a
    assert_equal [2, 3, 4, 5, 6, 7, 8, 9], a[2..(a.length - 1)]
    assert_equal [2, 3, 4, 5, 6, 7, 8, 9], a[2..-1]
    assert_equal %w[a b c d e], ("a".."e").to_a
  end

  # 4.3.2 Blocks
  test "4.3.2 each with braces and do..end" do
    assert_output("2\n4\n6\n8\n10\n") { assert_equal (1..5), (1..5).each { |i| puts 2 * i } }
    assert_output("2\n4\n6\n8\n10\n") do
      (1..5).each do |i|
        puts 2 * i
      end
    end
    assert_output("2\n--\n4\n--\n6\n--\n8\n--\n10\n--\n") do
      (1..5).each do |number|
        puts 2 * number
        puts "--"
      end
    end
  end

  test "4.3.2 times and map" do
    assert_output("Betelgeuse!\n" * 3) { assert_equal 3, 3.times { puts "Betelgeuse!" } }
    assert_equal [1, 4, 9, 16, 25], (1..5).map { |i| i**2 }
    assert_equal %w[a b c], %w[a b c]
    assert_equal %w[A B C], %w[a b c].map { |char| char.upcase }
    assert_equal %w[a b c], %w[A B C].map { |char| char.downcase }
    assert_equal %w[a b c], %w[A B C].map(&:downcase)
  end

  test "4.3.2 random subdomain" do
    letters = ("a".."z").to_a
    assert_equal 26, letters.length
    assert_equal letters, letters.shuffle.sort
    assert_equal 8, letters.shuffle[0..7].length
    subdomain = ("a".."z").to_a.shuffle[0..7].join
    assert_match(/\A[a-z]{8}\z/, subdomain)
  end

  # 4.3.3 Hashes and symbols
  test "4.3.3 hashes with string keys" do
    user = {}
    user["first_name"] = "Michael"
    user["last_name"]  = "Hartl"
    assert_equal "Michael", user["first_name"]
    assert_equal({ "first_name" => "Michael", "last_name" => "Hartl" }, user)
    assert_equal user, { "first_name" => "Michael", "last_name" => "Hartl" }
  end

  test "4.3.3 symbols are not strings" do
    assert_equal %w[n a m e], "name".split("")
    assert_raises(NoMethodError) { :name.split("") }
    assert_equal "raboof", "foobar".reverse
    assert_raises(NoMethodError) { :foobar.reverse }
    assert_raises(NameError) { eval(":foo-bar") }
    assert_raises(SyntaxError) { eval(":2foo") }
  end

  test "4.3.3 hashes with symbol keys and the new syntax" do
    user = { :name => "Michael Hartl", :email => "michael@example.com" }
    assert_equal "Michael Hartl", user[:name]
    assert_nil user[:password]
    h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
    h2 = { name: "Michael Hartl", email: "michael@example.com" }
    assert h1 == h2
  end

  test "4.3.3 nested hashes" do
    params = {}
    params[:user] = { name: "Michael Hartl", email: "mhartl@example.com" }
    assert_equal({ user: { name: "Michael Hartl", email: "mhartl@example.com" } }, params)
    assert_equal "mhartl@example.com", params[:user][:email]
  end

  test "4.3.3 each over a hash" do
    flash = { success: "It worked!", danger: "It failed." }
    assert_output("Key :success has value \"It worked!\"\nKey :danger has value \"It failed.\"\n") do
      flash.each do |key, value|
        puts "Key #{key.inspect} has value #{value.inspect}"
      end
    end
  end

  test "4.3.3 inspect and p" do
    assert_output("1\n2\n3\n4\n5\n") { puts (1..5).to_a }
    assert_output("[1, 2, 3, 4, 5]\n") { puts (1..5).to_a.inspect }
    assert_output("name\n:name\n") { puts :name, :name.inspect }
    assert_output("It worked!\n\"It worked!\"\n") { puts "It worked!", "It worked!".inspect }
    assert_output(":name\n") { assert_equal :name, p(:name) }
  end
end

# 4.3.4 CSS revisited — stylesheet_link_tag with and without parentheses / braces.
class StylesheetLinkTagTest < ActionView::TestCase
  test "4.3.4 parentheses and braces are optional" do
    with_parens = stylesheet_link_tag("application", media: "all", "data-turbolinks-track" => true)
    without     = stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true
    with_braces = stylesheet_link_tag "application", { media: "all", "data-turbolinks-track" => true }
    assert_equal with_parens, without
    assert_equal with_parens, with_braces
    assert_match 'rel="stylesheet"', without
    assert_match 'media="all"', without
    assert_match 'data-turbolinks-track="true"', without
  end
end
