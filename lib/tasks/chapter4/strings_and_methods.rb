# Section 4.2 — examples typed into `rails console` in the manual.
# Run with: bin/rails chapter4:strings

section "4.2.1 Комментарии"
17 + 42  # Сложение целых чисел

section "4.2.2 Строки"
""  # Пустая строка
"foo"  # Непустая строка
"foo" + "bar"  # Соединение строк
first_name = "Michael"  # Присвоение переменной
"#{first_name} Hartl"  # Интерполяция строки
last_name = "Hartl"
first_name + " " + last_name  # Соединение с пробелом
"#{first_name} #{last_name}"  # Равнозначная интерполяция

section "4.2.2 Вывод на экран"
puts "foo"  # Вывести строку на экран
print "foo"  # как puts, но без символа новой строки
print "foo\n"  # То же, что и puts "foo"

section "4.2.2 Строки в одинарных кавычках"
'foo'  # Строка в одинарных кавычках
'foo' + 'bar'
'#{foo} bar'  # Строки в одинарных кавычках не позволяют делать интерполяцию
'\n'  # Буквальная комбинация 'бэкслэш n'
'Новые строки (\n) и табуляция (\t) используют символ бэкслэш \.'

section "4.2.3 Объекты и передача сообщений"
"foobar".length  # Передача сообщения "length" строке
"foobar".empty?
"".empty?
s = "foobar"
if s.empty?
  "The string is empty"
else
  "The string is nonempty"
end
if s.nil?
  "The variable is nil"
elsif s.empty?
  "The string is empty"
elsif s.include?("foo")
  "The string includes 'foo'"
end
x = "foo"
y = ""
puts "Both strings are empty" if x.empty? && y.empty?
puts "One of the strings is empty" if x.empty? || y.empty?
puts "x is not empty" if !x.empty?
nil.to_s
nil.empty?
nil.to_s.empty?  # Последовательность сообщений
"foo".nil?
"".nil?
nil.nil?
string = "foobar"
puts "The string '#{string}' is nonempty." unless string.empty?
!!nil
!!0

section "4.2.4 Определение методов"
def string_message(str = '')
  if str.empty?
    "It's an empty string!"
  else
    "The string is nonempty."
  end
end
puts string_message("foobar")
puts string_message("")
puts string_message
# Вариант с явным return
def string_message(str = '')
  return "It's an empty string!" if str.empty?
  return "The string is nonempty."
end
puts string_message("")
puts string_message("foobar")
# Имя аргумента не имеет значения
def string_message(the_function_argument = '')
  if the_function_argument.empty?
    "It's an empty string!"
  else
    "The string is nonempty."
  end
end
puts string_message("")
puts string_message("foobar")

section "4.2.5 Возвращение к хелперу заголовка"
include ApplicationHelper
full_title
full_title("Help")
