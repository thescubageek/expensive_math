require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: [:spec]

namespace :expensive_math do
  desc "Estimate cost and time for mathematical expressions"
  task :estimate, [:expressions] do |t, args|
    require_relative 'lib/expensive_math'

    expressions = args[:expressions]&.split(';')&.map(&:strip) || []
    
    if expressions.empty?
      puts "Usage: rake expensive_math:estimate['2 + 3 * 4']"
      puts "       rake expensive_math:estimate['2 + 3; 5 * 7; 10 / 2']"
      exit 1
    end
    
    puts "Processing #{expressions.length} expressions: #{expressions.inspect}"
    
    # Configure for dry run mode by default
    ExpensiveMath.configure do |config|
      config.dry_run = true
    end
    
    # Show comparison table using all the cached benchmark times
    puts "📊 Comparison Table:"
    ExpensiveMath.format_estimation_table(expressions)
  end
end
