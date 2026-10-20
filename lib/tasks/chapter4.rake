# Runnable versions of every console example from chapter 4.
#
#   bin/rails chapter4:strings     # 4.2 Strings and methods
#   bin/rails chapter4:structures  # 4.3 Other data structures
#   bin/rails chapter4:classes     # 4.4 Ruby classes
#   bin/rails chapter4:all         # everything, in order
namespace :chapter4 do
  examples = {
    strings:    ["4.2 Strings and methods",       "strings_and_methods.rb"],
    structures: ["4.3 Other data structures",     "data_structures.rb"],
    classes:    ["4.4 Ruby classes",              "ruby_classes.rb"]
  }

  examples.each do |name, (title, file)|
    desc "Chapter #{title}: run the manual's console examples"
    task name => :environment do
      require_relative "chapter4/demo"
      puts "# #{'=' * 70}", "# Chapter #{title}", "# #{'=' * 70}"
      Chapter4Demo.run(File.expand_path("chapter4/#{file}", __dir__))
    end
  end

  desc "Run all chapter 4 console examples"
  task all: examples.keys
end
