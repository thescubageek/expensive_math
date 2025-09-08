require_relative "expensive_math/version"
require_relative "expensive_math/llm_client"
require_relative "expensive_math/operators"

module ExpensiveMath
  class Error < StandardError; end

  # Configuration for LLM API
  class << self
    attr_accessor :api_key, :api_endpoint, :model, :logger

    def configure
      yield(self)
    end

    def log(level, message)
      if logger
        logger.send(level, "[ExpensiveMath] #{message}")
      elsif level == :warn || level == :error
        # Fallback to stderr for warnings/errors if no logger configured
        $stderr.puts "[ExpensiveMath] #{level.upcase}: #{message}"
      end
    end
  end

  # Default configuration
  self.api_endpoint = "https://api.openai.com/v1/chat/completions"
  self.model = "gpt-3.5-turbo"
  self.logger = nil
end
