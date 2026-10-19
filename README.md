# Sample App — лабораторная работа 4

**Тема:** «Rails-приправленный Ruby» (глава 4 книги Michael Hartl,
[*Ruby on Rails Tutorial*](https://www.railstutorial.org/)).
Текст задания — `part 4.odt`. Проект продолжает лабораторную 3
(история коммитов сохранена).

## Задание

- написать хелпер `full_title`, чтобы страница без своего заголовка
  получала базовый «Ruby on Rails Tutorial Sample App» без лишней `|`;
- изучить строки, методы, массивы, диапазоны, блоки, хэши, символы, классы;
- написать класс пользователя с `attr_accessor` и `formatted_email`;
- упражнения 4.6.1–4.6.4.

## Что сделано (ветка `rails-flavored-ruby`)

### Хелпер `full_title`
| Шаг | Тесты |
|---|---|
| `test/helpers/application_helper_test.rb` — тесты хелпера | КРАСНЫЙ |
| `ApplicationHelper#full_title` (аргумент по умолчанию, тернарный оператор, интерполяция) | ЗЕЛЁНЫЙ |
| Макет: `<title><%= full_title(yield(:title)) %></title>`; тест Home ждёт только базовый заголовок | КРАСНЫЙ |
| Из `home.html.erb` убран `provide(:title, "Home")` | ЗЕЛЁНЫЙ |

### Класс пользователя — `lib/example_user.rb`
Класс назван `ExampleUser`, а не `User`, чтобы не конфликтовать с моделью
`User` из следующих глав, и оставлен в проекте вместе с тестами
`test/lib/example_user_test.rb`: атрибуты по умолчанию `nil`, присваивание
через аксессоры, создание из хэша, `formatted_email`.

### Упражнения
| № | Решение | Где |
|---|---|---|
| 4.6.1 | `StringTools.string_shuffle(s)` → `s.split("").shuffle.join` | `lib/string_tools.rb` |
| 4.6.2 | `String#shuffle` (+ `String#palindrome?` из 4.4.3) | `config/initializers/string_extensions.rb` |
| 4.6.3 | `params[:father]`, `[:mother]`, `[:child]` — вложенные хэши `{first:, last:}` | `test/lib/hash_exercises_test.rb` |
| 4.6.4 | `{"a"=>100,"b"=>200}.merge({"b"=>300})` → `{"a"=>100,"b"=>300}`: при совпадении ключей побеждает значение из аргумента | `test/lib/hash_exercises_test.rb` |

Все упражнения проверяются тестами (`test/lib/string_tools_test.rb` и др.).

## Запуск

```sh
bundle install
bin/rails test     # 14 tests, 29 assertions, 0 failures, 0 errors
bin/rails server   # http://localhost:3000
bin/rails console  # >> ExampleUser.new(name: "A", email: "a@b.c").formatted_email
```

Окружение: Ruby 3.4.10, Rails 8.1.
