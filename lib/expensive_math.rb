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
      @operators_patched && !Thread.current[:expensive_math_disabled]
    end

    def activate!
      return if @operators_patched
      
      # Set flag first, then require operators
      @operators_patched = true
      with_original_operators do
        require_relative "expensive_math/operators"
      end
    end

    def deactivate!
      # Note: Cannot truly unmonkeypatch in Ruby, but we can disable via enabled? check
      @operators_patched = false
    end

    def activated?
      !!@operators_patched
    end

    def with_original_operators
      old_value = Thread.current[:expensive_math_disabled]
      Thread.current[:expensive_math_disabled] = true
      yield
    ensure
      Thread.current[:expensive_math_disabled] = old_value
    end

    def log(level, message)
      # Use original operators for logging to avoid infinite loops
      with_original_operators do
        if logger
          logger.send(level, "[ExpensiveMath] #{message}")
        else
          # Fallback to stderr for warnings/errors if no logger configured
          $stderr.puts "[ExpensiveMath] #{level.upcase}: #{message}"
        end
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
