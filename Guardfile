# Guard watches the project and re-runs only the tests affected by a change.
#   bundle exec guard        # start; press Enter to run all tests, Ctrl-D to quit
#
# Adapted from Listing 3.42 of the Rails Tutorial for a Rails 8 app
# (no Spring, controller tests live in test/controllers).

guard :minitest, all_on_start: false do
  # Any test file re-runs itself.
  watch(%r{^test/.+_test\.rb$})

  # Changing the test helper re-runs the whole suite.
  watch("test/test_helper.rb") { "test" }

  # Routes and the shared layout affect every page.
  watch("config/routes.rb")                       { "test/controllers" }
  watch("app/views/layouts/application.html.erb") { "test/controllers" }

  # A controller or one of its views -> that controller's test.
  watch(%r{^app/controllers/(.+)_controller\.rb$}) do |m|
    "test/controllers/#{m[1]}_controller_test.rb"
  end
  watch(%r{^app/views/([^/]+)/.+\.html\.erb$}) do |m|
    "test/controllers/#{m[1]}_controller_test.rb"
  end

  # Helpers are tested on their own and through the pages that use them.
  watch(%r{^app/helpers/(.+)_helper\.rb$}) do |m|
    ["test/helpers/#{m[1]}_helper_test.rb", "test/controllers"]
  end

  # Models and plain Ruby code in lib/.
  watch(%r{^app/models/(.+)\.rb$}) { |m| "test/models/#{m[1]}_test.rb" }
  watch(%r{^lib/(.+)\.rb$})        { |m| "test/lib/#{m[1]}_test.rb" }

  # Core extensions loaded from initializers.
  watch(%r{^config/initializers/.+\.rb$}) { "test" }
end
