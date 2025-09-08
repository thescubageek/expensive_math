# frozen_string_literal: true

require_relative "expensive_math/version"
require_relative "expensive_math/llm_client"
require_relative "expensive_math/formatter"
require_relative "expensive_math/estimate"

module ExpensiveMath
  class Error < StandardError; end

  # Configuration for LLM API
  class << self
    attr_accessor :api_key, :api_endpoint, :model, :logger, :dry_run

    alias_method :dry_run?, :dry_run

    def configure
      yield(self)
    end

    def enabled?
      ENV['EXPENSIVE_MATH_ENABLED'] == 'true'
    end

    def log(level, message)
      if logger
        logger.send(level, "[ExpensiveMath] #{message}")
      else
        # Fallback to stderr for warnings/errors if no logger configured
        $stderr.puts "[ExpensiveMath] #{level.upcase}: #{message}"
      end
    end

    def estimate_expression(expression)
      Estimate.estimate_expression(expression)
    end

    def format_estimation_table(expressions)
      Estimate.format_estimation_table(expressions)
    end

    def print_estimation_details(expression)
      Estimate.print_estimation_details(expression)
    end
  end

  # Default configuration
  self.api_endpoint = "https://api.openai.com/v1/chat/completions"
  self.model = "gpt-5-nano"
  self.logger = nil
  self.dry_run = true # Default to dry run mode
end

# Load operators if enabled
if ExpensiveMath.enabled?
  require_relative "expensive_math/operators"
end
