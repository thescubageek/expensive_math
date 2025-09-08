require_relative "expensive_math/version"
require_relative "expensive_math/llm_client"
require_relative "expensive_math/operators"

module ExpensiveMath
  class Error < StandardError; end

  # Configuration for LLM API
  class << self
    attr_accessor :api_key, :api_endpoint, :model, :logger, :dry_run
    attr_reader :enabled

    alias_method :enabled?, :enabled
    alias_method :dry_run?, :dry_run

    def configure
      yield(self)
    end

    def enable!
      return if @enabled
      
      Operators.patch_numeric_classes!
      @enabled = true
    end

    def disable!
      @enabled = false
    end

    def log(level, message)
      # Prevent recursion by temporarily disabling expensive math during logging
      was_enabled = @enabled
      @enabled = false
      
      begin
        if logger
          logger.send(level, "[ExpensiveMath] #{message}")
        elsif level == :warn || level == :error
          # Fallback to stderr for warnings/errors if no logger configured
          $stderr.puts "[ExpensiveMath] #{level.upcase}: #{message}"
        end
      ensure
        @enabled = was_enabled
      end
    end

    def estimate_expression(expression)
      operation_count = count_operations(expression)
      
      # Cost calculation (GPT-5-nano pricing)
      cost_per_operation = 0.000002  # ~$0.000002 per operation
      estimated_cost = operation_count * cost_per_operation
      
      # Time calculation
      if dry_run?
        # Dry run mode: 500ms per operation
        estimated_time_ms = operation_count * 500
      else
        # Real API mode: 500-2000ms per operation (use average of 1250ms)
        estimated_time_ms = operation_count * 1250
      end
      
      {
        expression: expression,
        operation_count: operation_count,
        estimated_cost: estimated_cost,
        estimated_time_ms: estimated_time_ms,
        estimated_time_seconds: estimated_time_ms / 1000.0,
        mode: dry_run? ? "dry_run" : "api_calls"
      }
    end

    private

    def count_operations(expression)
      # Count mathematical operators in the expression
      # This is a simple regex-based approach
      operators = ['+', '-', '*', '/', '%', '**', '==', '!=', '<', '>', '<=', '>=', '<=>', '&', '|', '^']
      
      # Remove spaces and count operators
      cleaned = expression.gsub(/\s+/, '')
      
      operation_count = 0
      
      # Count each type of operator
      operators.each do |op|
        # Escape special regex characters
        escaped_op = Regexp.escape(op)
        operation_count += cleaned.scan(/#{escaped_op}/).length
      end
      
      # Handle special cases
      # ** should be counted as one operation, not two * operations
      operation_count -= cleaned.scan(/\*\*/).length
      
      # <= and >= should not double-count < and >
      operation_count -= cleaned.scan(/<=/).length
      operation_count -= cleaned.scan(/>=/).length
      
      # <=> should not triple-count
      operation_count -= (cleaned.scan(/<=>/).length * 2)
      
      # Minimum of 1 operation if we have any mathematical content
      operation_count > 0 ? operation_count : (cleaned.match?(/\d/) ? 1 : 0)
    end
  end

  # Default configuration
  self.api_endpoint = "https://api.openai.com/v1/chat/completions"
  self.model = "gpt-5-nano"
  self.logger = nil
  self.dry_run = false
end
