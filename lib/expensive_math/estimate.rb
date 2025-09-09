# frozen_string_literal: true

require 'benchmark'

module ExpensiveMath
  module Estimate
    class << self
      def estimate_expression(expression)
        return unless ExpensiveMath.dry_run?
        
        operation_count = count_operations(expression)
        
        # Cost calculation (GPT-5-nano pricing)
        cost_per_operation = 0.000002  # ~$0.000002 per operation
        estimated_cost = operation_count * cost_per_operation
        
        # Simulate a 0.5s - 2s response time, which might actually be faster than the real API
        estimated_time_ms = operation_count * rand(500..2000)
        
        {
          expression: expression,
          operation_count: operation_count,
          estimated_cost: estimated_cost,
          estimated_time_ms: estimated_time_ms,
          estimated_time_seconds: estimated_time_ms / 1000.0,
          mode: "dry_run"
        }
      end

      def format_estimation_table(expressions)
        puts "| Expression | Operations | Regular Ruby | ExpensiveMath | Time Increase | Cost |"
        puts "|------------|------------|--------------|---------------|---------------|------|"
        
        expressions.each do |expr|
          estimate = estimate_expression(expr)
          
          # Benchmark regular Ruby performance
          benchmarked_time_ms = benchmark_expression(expr)
          regular_time = "#{benchmarked_time_ms}ms"
          
          # ExpensiveMath time and cost
          operation_count = estimate[:operation_count].to_s
          expensive_time = "#{estimate[:estimated_time_ms]}ms"
          expensive_cost = format_cost(estimate[:estimated_cost])
          
          # Calculate time increase
          time_increase_percent = ((estimate[:estimated_time_ms] / benchmarked_time_ms - 1) * 100).round(0)
          time_increase = "#{time_increase_percent.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')}%"
          
          # Format expression to fit in table (truncate if too long)
          display_expr = expr.length > 15 ? "#{expr[0..12]}..." : expr
          
          puts "| #{display_expr.ljust(10)} | #{operation_count.ljust(10)} | #{regular_time.ljust(12)} | #{expensive_time.ljust(13)} | #{time_increase.ljust(13)} | #{expensive_cost.ljust(4)} |"
        end
      end

      def print_estimation_details(expression)
        estimate = estimate_expression(expression)
        benchmarked_time_ms = benchmark_expression(expression)
        
        puts "🧮 Expression Analysis: #{expression}"
        puts "=" * 50
        puts "Operations detected: #{estimate[:operation_count]}"
        puts "Mode: #{estimate[:mode]}"
        puts
        puts "⏱️  Time Estimation:"
        puts "  Regular Ruby: #{benchmarked_time_ms}ms"
        puts "  ExpensiveMath: #{estimate[:estimated_time_ms]}ms (#{estimate[:estimated_time_seconds]}s)"
        time_increase_percent = ((estimate[:estimated_time_ms] / benchmarked_time_ms - 1) * 100).round(0)
        puts "  Time increase: #{time_increase_percent.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\\1,')}%"
        puts
        puts "💰 Cost Estimation:"
        puts "  Regular Ruby: $0.00"
        puts "  ExpensiveMath: #{format_cost(estimate[:estimated_cost])}"
        puts "  Cost increase: ∞"
        puts
        
        # Return the benchmarked time for reuse
        benchmarked_time_ms
      end

      private

      def count_operations(expression)
        # Remove spaces and count operators
        cleaned = expression.gsub(/\s+/, '')
        
        operation_count = 0
        
        # Count each type of operator, handling ** before * to avoid double counting
        operators_to_count = ExpensiveMath::LLMClient::OPERATOR_PROMPTS.keys
        
        # First, count ** operations and replace them temporarily to avoid * conflicts
        temp_cleaned = cleaned.dup
        double_star_count = temp_cleaned.scan(/\*\*/).length
        temp_cleaned.gsub!(/\*\*/, 'DOUBLESTAR')
        operation_count += double_star_count
        
        # Then count all other operators on the modified string
        operators_to_count.each do |op|
          next if op == :** # Already handled above
          escaped_op = Regexp.escape(op)
          operation_count += temp_cleaned.scan(/#{escaped_op}/).length
        end
        
        # Also count != operations since they use the expensive == implementation
        operation_count += cleaned.scan(/!=/).length
        
        # <= and >= should not double-count < and >
        operation_count -= cleaned.scan(/<=/).length
        operation_count -= cleaned.scan(/>=/).length
        
        # <=> should not triple-count
        operation_count -= (cleaned.scan(/<=>/).length * 2)
        
        # Minimum of 1 operation if we have any mathematical content
        operation_count > 0 ? operation_count : (cleaned.match?(/\d/) ? 1 : 0)
      end

      def benchmark_expression(expression)
        evaluable_expr = sanitize_expression_for_eval(expression)
        return 0.0001 if evaluable_expr.nil?
        
        time = Benchmark.realtime do
          1000.times do
            eval(evaluable_expr)
          end
        end
        
        time_per_operation_ms = (time * 1000) / 1000.0
        
        if time_per_operation_ms < 0.0001
          0.0001
        else
          time_per_operation_ms.round(4)
        end
      end

      def sanitize_expression_for_eval(expression)
        cleaned = expression.dup
        cleaned.gsub!(/^\s*\w+\s*=\s*/, '')
        cleaned.gsub!(/[a-zA-Z]/, '')
        
        safe_pattern = /\A[\d\s\+\-\*\/\%\(\)\*\*\<\>\=\!\&\|]+\z/
        
        cleaned.match?(safe_pattern) && !cleaned.empty? ? cleaned : nil
      end

      def format_cost(cost)
        return "$0.00" if cost == 0
        
        # Format with high precision and remove trailing zeros
        formatted = sprintf("%.15f", cost).sub(/\.?0+$/, '')
        
        # Ensure we have at least 2 decimal places for readability
        if !formatted.include?('.')
          formatted += ".00"
        elsif formatted.split('.')[1].length < 2
          formatted += "0" * (2 - formatted.split('.')[1].length)
        end
        
        "$#{formatted}"
      end
    end
  end
end
