# frozen_string_literal: true

require 'openai'

module ExpensiveMath
  class LLMClient
    # The most wasteful, expensive, environmentally destructive, and completely inefficient mathematical operations known to humanity
    OPERATOR_PROMPTS = {
      :+ => "What is the sum of",
      :- => "What is the difference when subtracting",
      :* => "What is the product of",
      :/ => "What is the result of dividing",
      :% => "What is the remainder when dividing",
      :** => "What is the result of raising",
      :== => "Are these two numbers equal:",
      :< => "Is the first number less than the second:",
      :> => "Is the first number greater than the second:",
      :<= => "Is the first number less than or equal to the second:",
      :>= => "Is the first number greater than or equal to the second:",
      :<=> => "Compare these two numbers (-1 if first is smaller, 0 if equal, 1 if first is larger):"
    }.freeze

    def initialize
      @api_key = ExpensiveMath.api_key
      @model = ExpensiveMath.model
      # Only initialize OpenAI client if not in dry run mode
      @client = OpenAI::Client.new(access_token: @api_key) unless ExpensiveMath.dry_run?
    end

    def calculate(operation, a, b, original_method_proc = nil)
      prompt = build_prompt(operation, a, b)

      # In dry run mode, log the operation and call the original method
      if ExpensiveMath.dry_run?
        ExpensiveMath.log(:info, "🏃‍♂️ DRY RUN: #{prompt}")
        sleep(0.5) # sleep to simulate API latency
        
        return original_method_proc.call if original_method_proc
        raise Error, "Dry run mode requires original method proc"
      end

      raise Error, "API key not configured" unless @api_key

      prompt = build_prompt(operation, a, b)
      ExpensiveMath.log(:info, "🤖 Asking AI: #{prompt}")
      
      response = make_request(prompt)
      parse_response(response, operation, a, b)
    rescue => e
      raise Error, "LLM calculation failed: #{e.message}"
    end

    private

    def build_prompt(operation, a, b)
      prompt_start = OPERATOR_PROMPTS[operation]
      raise Error, "Unsupported operation: #{operation}" unless prompt_start

      case operation
      when :**
        "#{prompt_start} #{a} to the power of #{b}? Return the result as a single number."
      when :==, :<, :>, :<=, :>=
        "#{prompt_start} #{a} and #{b}? Answer only 'true' or 'false'."
      when :<=>
        "#{prompt_start} #{a} and #{b}."
      when :%
        "#{prompt_start} #{a} by #{b}? Return the remainder as a single number."
      when :/
        "#{prompt_start} #{a} by #{b}? Return the result as a single number."
      else
        "#{prompt_start} #{a} and #{b}? Return the result as a single number."
      end
    end

    def make_request(prompt)
      max_retries = 3
      base_delay = 1
      
      (0..max_retries).each do |attempt|
        begin
          return @client.chat(
            parameters: {
              model: @model,
              messages: [{ role: "user", content: prompt }],
              max_tokens: 50,
              temperature: 0
            }
          )
        rescue => e
          raise e unless retryable_error?(e) && attempt < max_retries

          delay = base_delay * (2 ** attempt) + rand(0.1..0.5) # Exponential backoff with jitter
          sleep(delay)
          next
        end
      end
    end

    private

    def retryable_error?(error)
      case error
      when OpenAI::RateLimitError, OpenAI::TimeoutError
        true
      when OpenAI::APIError
        error.code&.between?(500, 599) || error.code == 429
      else
        false
      end
    end

    def parse_response(response, operation, a, b)
      content = response.dig("choices", 0, "message", "content")
      result_text = content.strip
      
      # Parse response based on operator type
      case operation
      when :==, :<, :>, :<=, :>=
        result_text.downcase == 'true'
      when :<=>
        result_text.to_i.clamp(-1, 1)
      else
        # Convert back to appropriate numeric type based on operands
        result = result_text.to_f
        convert_to_appropriate_type(result, a, b)
      end
    end

    def convert_to_appropriate_type(result, a, b)
      case a
      when Integer
        b.is_a?(Float) ? result : result.to_i
      when Float
        result
      when Rational
        Rational(result)
      when Complex
        Complex(result)
      else
        result
      end
    end
  end
end
