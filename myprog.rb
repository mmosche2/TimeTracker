puts "A"
require 'rubygems'
puts "B"
puts ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

puts "C"
puts "FILE" if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
puts "With env: #{ENV['BUNDLE_GEMFILE']}"
Bundler.with_clean_env do
  puts "With clean: #{ENV['BUNDLE_GEMFILE']}"
end