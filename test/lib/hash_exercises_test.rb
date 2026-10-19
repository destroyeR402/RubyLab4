require "test_helper"

# Exercises 4.6.3-4.6.4: nested hashes and Hash#merge.
class HashExercisesTest < ActiveSupport::TestCase
  def setup
    person1 = { first: "Sergey",  last: "Ivanov" }
    person2 = { first: "Anna",    last: "Ivanova" }
    person3 = { first: "Dmitry",  last: "Ivanov" }
    @params = { father: person1, mother: person2, child: person3 }
  end

  test "nested hashes give access to each person's name" do
    assert_equal "Sergey", @params[:father][:first]
    assert_equal "Ivanova", @params[:mother][:last]
    assert_equal "Dmitry", @params[:child][:first]
  end

  test "merge overrides values for duplicate keys" do
    merged = { "a" => 100, "b" => 200 }.merge({ "b" => 300 })
    assert_equal({ "a" => 100, "b" => 300 }, merged)
  end
end
