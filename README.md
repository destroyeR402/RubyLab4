# Sample App

The sample application from Michael Hartl's
[*Ruby on Rails Tutorial: Learn Web Development with Rails*](https://www.railstutorial.org/),
chapters 3–4 — "Mostly static pages" and "Rails-flavored Ruby".

## What's here

- A `StaticPagesController` with `home`, `help`, `about` and `contact` actions.
- Shared site layout (`app/views/layouts/application.html.erb`); each page sets
  its own title with `provide(:title, ...)`, rendered as
  `"<Page> | Ruby on Rails Tutorial Sample App"`.
- `root` routes to `static_pages#home`.
- A `full_title` helper (`ApplicationHelper`) that falls back to the base title
  when a page does not provide its own.
- Plain-Ruby exercises from chapter 4 in `lib/` (`ExampleUser`, `StringTools`)
  and `String#palindrome?` / `String#shuffle` core extensions, all unit-tested.
- Controller tests for every page, written test-first (Red → Green → Refactor).

## Requirements

- Ruby 3.4.10 (see `.ruby-version`)
- Rails 8.1

## Getting started

```sh
bundle install
bin/rails test     # run the test suite
bin/rails server   # http://localhost:3000
```
