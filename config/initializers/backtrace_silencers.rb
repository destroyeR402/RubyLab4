# Be sure to restart your server when you modify this file.

# Hide lines coming from gems installed through rbenv, so failing tests point
# straight at the application code (Rails Tutorial, Listing 3.41).
Rails.backtrace_cleaner.add_silencer { |line| line.include?("/.rbenv/") }

# Uncomment to see the full backtrace when debugging framework code:
# Rails.backtrace_cleaner.remove_silencers!
