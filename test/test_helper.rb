ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # Parallel (forked) workers hang on this machine once the suite passes the
    # default threshold of 50 tests, so stay single-process up to 200 tests.
    parallelize(workers: :number_of_processors, threshold: 200)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
