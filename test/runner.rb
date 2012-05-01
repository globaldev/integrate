require 'simplecov'

SimpleCov.start do
  command_name "Unit Tests"
  add_filter "test"
end

Dir[File.expand_path("../**/*_test.rb", __FILE__)].each {|test| require test}
