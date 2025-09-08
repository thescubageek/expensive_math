require_relative "expensive_math/version"
require_relative "expensive_math/llm_client"
require_relative "expensive_math/operators"

module ExpensiveMath
  class Error < StandardError; end

  # Configuration for LLM API
  class << self
    attr_accessor :api_key, :api_endpoint, :model

    def configure
      yield(self)
    end
  end

  # Default configuration
  self.api_endpoint = "https://api.openai.com/v1/chat/completions"
  self.model = "gpt-3.5-turbo"
end
