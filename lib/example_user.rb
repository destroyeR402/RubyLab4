# Plain Ruby class from section 4.4.5 — a preview of the User model.
# Named ExampleUser so it doesn't clash with the real User model later on.
class ExampleUser
  attr_accessor :name, :email

  def initialize(attributes = {})
    @name  = attributes[:name]
    @email = attributes[:email]
  end

  def formatted_email
    "#{@name} <#{@email}>"
  end
end
