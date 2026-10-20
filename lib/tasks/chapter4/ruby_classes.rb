# Section 4.4 — examples typed into `rails console` in the manual.
# Run with: bin/rails chapter4:classes

section "4.4.1 Конструкторы"
s = "foobar"  # Литеральный конструктор строки с использованием двойных кавычек.
s.class
s = String.new("foobar")  # Именованный конструктор для строки
s.class
s == "foobar"
a = Array.new([1, 3, 2])
h = Hash.new
h[:foo]  # Попытка обратиться к значению несуществующего ключа :foo.
h = Hash.new(0)  # Теперь несуществующие ключи будут возвращать 0 вместо nil.
h[:foo]

section "4.4.2 Наследование классов"
s = String.new("foobar")
s.class  # Поиск класса, к которому принадлежит s.
s.class.superclass  # Поиск суперкласса, к которому принадлежит String.
s.class.superclass.superclass  # В Ruby 1.9 есть новый базовый класс BasicObject.
s.class.superclass.superclass.superclass
class Word
  def palindrome?(string)
    string == string.reverse
  end
end
w = Word.new  # Создаём новый объект класса Word.
w.palindrome?("foobar")
w.palindrome?("level")
# В консоли здесь нужно выйти и зайти заново, чтобы забыть старый Word:
Object.send(:remove_const, :Word)
class Word < String  # Word наследуется от String.
  # Возвращает true, если слово является перевёртышем.
  def palindrome?
    self == self.reverse  # self - это сама строка.
  end
end
s = Word.new("level")  # Создание нового слова "level".
s.palindrome?  # У слов есть метод palindrome?.
s.length  # Слова также наследуют все нормальные методы строк.
s.class
s.class.superclass
s.class.superclass.superclass

section "4.4.3 Изменение встроенных классов"
# В чистом Rails здесь был бы NoMethodError, но в этом проекте String#palindrome?
# уже добавлен в config/initializers/string_extensions.rb.
"level".palindrome?
class String
  # Возвращает true, если строка является перевёртышем.
  def palindrome?
    self == self.reverse
  end
end
"deified".palindrome?
"".blank?
"    ".empty?
"    ".blank?
nil.blank?

section "4.4.4 Класс Controller"
controller = StaticPagesController.new
controller.class
controller.class.superclass
controller.class.superclass.superclass
controller.class.superclass.superclass.superclass
controller.class.superclass.superclass.superclass.superclass
controller.class.superclass.superclass.superclass.superclass.superclass
controller.home

section "4.4.5 Класс User"
# В методичке: require './example_user'. Здесь класс лежит в lib/example_user.rb
# под именем ExampleUser и загружается Rails автоматически.
example = ExampleUser.new
example.name  # nil, поскольку attributes[:name] - nil
example.name = "Example User"  # Назначение не-nil имени
example.email = "user@example.com"  # и не-nil email адреса
example.formatted_email
user = ExampleUser.new(name: "Michael Hartl", email: "mhartl@example.com")
user.formatted_email
