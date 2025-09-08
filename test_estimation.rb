#!/usr/bin/env ruby

require_relative 'lib/expensive_math'

puts "🧮 ExpensiveMath Expression Estimation Demo"
puts "=" * 50

# Test expressions with varying complexity
test_expressions = [
  "2 + 3",
  "10 * 5 - 3",
  "2 ** 8 / 4 + 1",
  "(15 + 5) * 2 - 8 / 4",
  "100 / 25 + 50 * 2 - 10 % 3",
  "5 == 5 && 3 < 7",
  "x = 2 + 3 * 4 - 1 / 2",
  "complex = (a + b) * (c - d) / (e ** 2)"
]

puts "Testing in DRY RUN mode:"
puts "-" * 30

ExpensiveMath.configure do |config|
  config.dry_run = true
end

test_expressions.each do |expr|
  estimate = ExpensiveMath.estimate_expression(expr)
  
  puts "Expression: #{expr}"
  puts "  Operations: #{estimate[:operation_count]}"
  puts "  Est. Time: #{estimate[:estimated_time_seconds]}s"
  puts "  Est. Cost: $#{estimate[:estimated_cost].round(6)}"
  puts "  Mode: #{estimate[:mode]}"
  puts
end

puts "\nTesting in API mode:"
puts "-" * 30

ExpensiveMath.configure do |config|
  config.dry_run = false
end

test_expressions.each do |expr|
  estimate = ExpensiveMath.estimate_expression(expr)
  
  puts "Expression: #{expr}"
  puts "  Operations: #{estimate[:operation_count]}"
  puts "  Est. Time: #{estimate[:estimated_time_seconds]}s"
  puts "  Est. Cost: $#{estimate[:estimated_cost].round(6)}"
  puts "  Mode: #{estimate[:mode]}"
  puts
end

# Demonstrate cost scaling
puts "💰 Cost Scaling Examples:"
puts "-" * 30

large_expressions = [
  "Simple loop equivalent: 1000 operations",
  "Complex calculation: 10000 operations", 
  "Heavy computation: 100000 operations"
]

operation_counts = [1000, 10000, 100000]

operation_counts.each_with_index do |count, i|
  cost = count * 0.000002
  time_dry_run = count * 0.5  # seconds
  time_api = count * 1.25     # seconds
  
  puts large_expressions[i]
  puts "  Cost: $#{cost.round(4)}"
  puts "  Time (dry run): #{time_dry_run}s (#{(time_dry_run/60).round(1)} min)"
  puts "  Time (API): #{time_api}s (#{(time_api/60).round(1)} min)"
  puts
end

puts "🎯 Use ExpensiveMath.estimate_expression(expr) to plan your expensive calculations!"
