# Section 4.3 — examples typed into `rails console` in the manual.
# Run with: bin/rails chapter4:structures

section "4.3.1 Массивы и диапазоны"
"foo bar     baz".split  # Разбиение строки на трех-элементный массив.
"fooxbarxbazx".split('x')
a = [42, 8, 17]
a[0]  # В Ruby используются квадратные скобки для доступа к массиву.
a[1]
a[2]
a[-1]  # Индексы могут быть даже отрицательными!
a.first
a.second  # Метод добавлен Rails
a.last
a.last == a[-1]  # Сравнение с помощью ==
x = a.length  # Как и строки, массивы отвечают на метод 'length'.
x == 3
x == 1
x != 1
x >= 1
x < 1
a.empty?
a.include?(42)
a.sort
a.reverse
a.shuffle
a  # Ни один из методов выше не изменил сам массив
a.sort!  # "Бэнг"-метод изменяет массив
a
a = [42, 8, 17]
a.push(6)  # Добавление 6 в массив
a << 7  # Добавление 7 в массив
a << "foo" << "bar"  # Последовательное добавление в массив
a.join  # Объединение без ничего.
a.join(', ')  # Объединение через запятую.
0..9
0..9.to_a  # Упс, вызвали to_a на 9.
(0..9).to_a  # Используйте скобки, чтобы вызвать to_a на диапазон.
a = %w[foo bar baz quux]  # Используем %w для создания массива строк.
a[0..2]
a = (0..9).to_a
a[2..(a.length-1)]  # Явное использование длины массива.
a[2..-1]  # Использование трюка с индексом -1
('a'..'e').to_a

section "4.3.2 Блоки"
(1..5).each { |i| puts 2 * i }
(1..5).each do |i|
  puts 2 * i
end
(1..5).each do |number|
  puts 2 * number
  puts '--'
end
3.times { puts "Betelgeuse!" }  # 3.times принимает блок без переменных.
(1..5).map { |i| i**2 }  # Знак ** обозначает 'степень'.
%w[a b c]  # %w создаёт массив строк
%w[a b c].map { |char| char.upcase }
%w[A B C].map { |char| char.downcase }
%w[A B C].map(&:downcase)
# Случайный субдомен из раздела 1.5.4, шаг за шагом:
('a'..'z').to_a  # Массив букв в алфавитном порядке
('a'..'z').to_a.shuffle  # Перемешиваем его.
('a'..'z').to_a.shuffle[0..7]  # Вытаскиваем первые восемь элементов.
('a'..'z').to_a.shuffle[0..7].join  # Объединяем их, чтобы сделать одну строку.

section "4.3.3 Хэши и символы"
user = {}  # {} Это пустой хэш.
user["first_name"] = "Michael"  # Ключ "first_name", значение "Michael"
user["last_name"] = "Hartl"  # Ключ "last_name", значение "Hartl"
user["first_name"]  # Доступ к элементам аналогичен массивам.
user  # Буквальное представление хэша.
user = { "first_name" => "Michael", "last_name" => "Hartl" }
"name".split('')
:name.split('')
"foobar".reverse
:foobar.reverse
:foo-bar
eval(":2foo")  # Символ не может начинаться с цифры
user = { :name => "Michael Hartl", :email => "michael@example.com" }
user[:name]  # Доступ к значению, соответствующему :name.
user[:password]  # Доступ к значению неопределенного ключа.
h1 = { :name => "Michael Hartl", :email => "michael@example.com" }
h2 = { name: "Michael Hartl", email: "michael@example.com" }
h1 == h2
params = {}  # Определение хэша 'params' (сокращение от 'parameters').
params[:user] = { name: "Michael Hartl", email: "mhartl@example.com" }
params
params[:user][:email]
flash = { success: "It worked!", danger: "It failed." }
flash.each do |key, value|
  puts "Key #{key.inspect} has value #{value.inspect}"
end
puts (1..5).to_a  # Вывести массив.
puts (1..5).to_a.inspect  # Вывести массив буквально.
puts :name, :name.inspect
puts "It worked!", "It worked!".inspect
p :name  # Такой же вывод, как и 'puts :name.inspect'

section "4.3.4 Вновь CSS"
# В представлениях хелперы Rails доступны сразу; здесь берём их у контроллера.
def stylesheet_link_tag(*args) = ApplicationController.helpers.stylesheet_link_tag(*args)
# Скобки при вызове функции не обязательны.
stylesheet_link_tag('application', media: 'all', 'data-turbolinks-track' => true)
stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true
# Фигурные скобки необязательны, если хэш является последним аргументом функции.
stylesheet_link_tag 'application', { media: 'all', 'data-turbolinks-track' => true }
