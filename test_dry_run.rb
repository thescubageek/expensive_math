#!/usr/bin/env ruby

require_relative 'lib/expensive_math'
require 'logger'

# Configure ExpensiveMath with dry run enabled
ExpensiveMath.configure do |config|
  config.dry_run = true
  config.logger = Logger.new(STDOUT)
end

# Enable ExpensiveMath
ExpensiveMath.enable!

puts "Testing dry run functionality..."
puts "ExpensiveMath enabled: #{ExpensiveMath.enabled?}"
puts "Dry run mode: #{ExpensiveMath.dry_run?}"
puts

# Test basic arithmetic operations
puts "Testing: 2 + 3"
result = 2 + 3
puts "Result: #{result}"
puts

puts "Testing: 10 - 4"
result = 10 - 4
puts "Result: #{result}"
puts

puts "Testing: 6 * 7"
result = 6 * 7
puts "Result: #{result}"
puts

puts "Testing: 15 / 3"
result = 15 / 3
puts "Result: #{result}"
puts

puts "Testing: 2 ** 8"
result = 2 ** 8
puts "Result: #{result}"
puts

puts "Testing: 17 % 5"
result = 17 % 5
puts "Result: #{result}"
puts

# Test comparison operations
puts "Testing: 5 == 5"
result = 5 == 5
puts "Result: #{result}"
puts

puts "Testing: 3 < 7"
result = 3 < 7
puts "Result: #{result}"
puts

puts "Testing: 8 > 2"
result = 8 > 2
puts "Result: #{result}"
puts

puts "Testing: 5 <=> 3"
result = 5 <=> 3
puts "Result: #{result}"
puts

puts "Dry run test completed!"
