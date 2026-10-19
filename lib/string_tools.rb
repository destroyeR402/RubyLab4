# Exercise 4.6.1: shuffle the letters of a string using split, shuffle and join.
module StringTools
  module_function

  def string_shuffle(s)
    s.split("").shuffle.join
  end
end
