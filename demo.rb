#!/usr/bin/env ruby

require_relative 'lib/expensive_math'
require 'logger'
require 'benchmark'

puts "🔥 ExpensiveMath Demo - The Most Expensive Way to Do Math! 🔥"
puts "=" * 60
puts

# First, let's demo dry run mode (no API key needed)
puts "📋 DEMO 1: DRY RUN MODE (No API Key Required)"
puts "-" * 40

ExpensiveMath.configure do |config|
  config.dry_run = true
  config.logger = Logger.new(STDOUT, level: Logger::INFO)
end

puts "✅ Enabling ExpensiveMath in dry run mode..."
ExpensiveMath.enable!

puts "Status: Enabled=#{ExpensiveMath.enabled?}, DryRun=#{ExpensiveMath.dry_run?}"
puts

# Demo basic arithmetic operations
puts "🧮 Basic Arithmetic Operations:"
operations = [
  [2, :+, 3],
  [10, :-, 4],
  [6, :*, 7],
  [15, :/, 3],
  [2, :**, 8],
  [17, :%, 5]
]

operations.each do |a, op, b|
  print "#{a} #{op} #{b} = "
  time = Benchmark.realtime do
    result = a.send(op, b)
    puts result
  end
  puts "  ⏱️  Took #{(time * 1000).round(0)}ms (includes 500ms simulated latency)"
  puts
end

# Demo comparison operations
puts "🔍 Comparison Operations:"
comparisons = [
  [5, :==, 5],
  [3, :<, 7],
  [8, :>, 2],
  [4, :<=, 4],
  [9, :>=, 6],
  [5, :<=>, 3]
]

comparisons.each do |a, op, b|
  print "#{a} #{op} #{b} = "
  result = a.send(op, b)
  puts result
  puts
end

puts "🛑 Disabling ExpensiveMath..."
ExpensiveMath.disable!
puts "Status: Enabled=#{ExpensiveMath.enabled?}"
puts
puts

# Now demo what would happen with real API calls (but still in dry run)
puts "📋 DEMO 2: WHAT REAL API MODE WOULD LOOK LIKE"
puts "-" * 50

puts "⚠️  In real API mode, you would need:"
puts "   • OpenAI API key: config.api_key = ENV['OPENAI_API_KEY']"
puts "   • config.dry_run = false"
puts "   • Each operation costs ~$0.000002 and takes 500-2000ms"
puts

# GPT-4o-nano pricing: $0.05/M input tokens, $0.40/M output tokens
# Typical math prompt: ~20 input tokens, ~2 output tokens
# Cost breakdown:
#   Input:  20 tokens × $0.00000005 = $0.000001
#   Output:  2 tokens × $0.0000004  = $0.0000008
#   Total per operation: ~$0.000002
puts "💸 Cost Calculation for Demo Operations:"
total_operations = operations.length + comparisons.length
estimated_cost = total_operations * 0.000002
puts "   • Total operations: #{total_operations}"
puts "   • Estimated cost: $#{estimated_cost.round(6)} (GPT-4o-nano)"
puts "   • Cost per operation: ~$0.000002"
puts "   • Estimated time: #{total_operations * 1.0}+ seconds"
puts

# Demo with different numeric types
puts "📋 DEMO 3: DIFFERENT NUMERIC TYPES"
puts "-" * 40

ExpensiveMath.configure do |config|
  config.dry_run = true
  config.logger = nil  # Disable logging for cleaner output
end

ExpensiveMath.enable!

puts "🔢 Integer operations:"
puts "42 + 8 = #{42 + 8}"

puts "🔢 Float operations:"
puts "3.14 * 2.0 = #{3.14 * 2.0}"

puts "🔢 Rational operations:"
puts "Rational(1,2) + Rational(1,3) = #{Rational(1,2) + Rational(1,3)}"

puts "🔢 Mixed type operations:"
puts "10 / 3.0 = #{10 / 3.0}"

ExpensiveMath.disable!
puts

# Performance comparison
puts "📋 DEMO 4: PERFORMANCE COMPARISON"
puts "-" * 40

puts "⚡ Normal Ruby Math:"
time_normal = Benchmark.realtime do
  1000.times { 2 + 3 }
end
puts "1000 additions: #{(time_normal * 1000).round(2)}ms"

puts "🐌 ExpensiveMath (dry run simulation):"
ExpensiveMath.configure { |c| c.dry_run = true; c.logger = nil }
ExpensiveMath.enable!

time_expensive = Benchmark.realtime do
  2 + 3  # Just one operation due to 500ms sleep
end
ExpensiveMath.disable!

puts "1 addition: #{(time_expensive * 1000).round(0)}ms"
puts "Slowdown factor: #{(time_expensive / (time_normal / 1000)).round(0)}x"
puts

puts "🎉 Demo Complete!"
puts "💡 To use with real API calls:"
puts "   1. Get an OpenAI API key"
puts "   2. Set config.api_key = 'your-key'"
puts "   3. Set config.dry_run = false"
puts "   4. Each math operation costs ~$0.000002"
puts "   5. 1000 operations = ~$0.002 total cost"
puts "   6. Still prepare your wallet! 💸 (it adds up!)"
