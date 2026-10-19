# Core extensions to String from sections 4.4.3 and exercise 4.6.2.
class String
  # Returns true if the string reads the same backwards.
  def palindrome?
    self == reverse
  end

  # Returns a copy of the string with its characters shuffled.
  def shuffle
    split("").shuffle.join
  end
end
