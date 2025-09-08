RSpec.describe ExpensiveMath do
  # Store original configuration before tests
  let(:original_config) do
    {
      api_key: ExpensiveMath.api_key,
      logger: ExpensiveMath.logger,
      model: ExpensiveMath.model,
      api_endpoint: ExpensiveMath.api_endpoint
    }
  end

  # Restore original configuration after each test
  around(:each) do |example|
    # Store original values
    saved_config = {
      api_key: ExpensiveMath.api_key,
      logger: ExpensiveMath.logger,
      model: ExpensiveMath.model,
      api_endpoint: ExpensiveMath.api_endpoint
    }

    example.run

    # Restore original values
    ExpensiveMath.api_key = saved_config[:api_key]
    ExpensiveMath.logger = saved_config[:logger]
    ExpensiveMath.model = saved_config[:model]
    ExpensiveMath.api_endpoint = saved_config[:api_endpoint]
  end

  it "has a version number" do
    expect(ExpensiveMath::VERSION).not_to be nil
  end

  describe "configuration" do
    it "allows setting api_key" do
      ExpensiveMath.configure do |config|
        config.api_key = "test-key"
      end
      expect(ExpensiveMath.api_key).to eq("test-key")
    end

    it "allows setting logger" do
      logger = double("logger")
      ExpensiveMath.configure do |config|
        config.logger = logger
      end
      expect(ExpensiveMath.logger).to eq(logger)
    end

    it "allows setting model" do
      ExpensiveMath.configure do |config|
        config.model = "gpt-4"
      end
      expect(ExpensiveMath.model).to eq("gpt-4")
    end

    it "has default values" do
      expect(ExpensiveMath.api_endpoint).to eq("https://api.openai.com/v1/chat/completions")
      expect(ExpensiveMath.model).to eq("gpt-3.5-turbo")
      expect(ExpensiveMath.logger).to be_nil
    end
  end

  describe "logging" do
    context "with logger configured" do
      let(:logger) { double("logger") }
      
      before do
        ExpensiveMath.logger = logger
      end

      it "logs info messages to configured logger" do
        expect(logger).to receive(:info).with("[ExpensiveMath] test message")
        ExpensiveMath.log(:info, "test message")
      end

      it "logs warn messages to configured logger" do
        expect(logger).to receive(:warn).with("[ExpensiveMath] warning message")
        ExpensiveMath.log(:warn, "warning message")
      end

      it "logs error messages to configured logger" do
        expect(logger).to receive(:error).with("[ExpensiveMath] error message")
        ExpensiveMath.log(:error, "error message")
      end
    end

    context "without logger configured" do
      before do
        ExpensiveMath.logger = nil
      end

      it "outputs warnings to stderr" do
        expect($stderr).to receive(:puts).with("[ExpensiveMath] WARN: warning message")
        ExpensiveMath.log(:warn, "warning message")
      end

      it "outputs errors to stderr" do
        expect($stderr).to receive(:puts).with("[ExpensiveMath] ERROR: error message")
        ExpensiveMath.log(:error, "error message")
      end

      it "silently ignores info messages" do
        expect($stderr).not_to receive(:puts)
        ExpensiveMath.log(:info, "info message")
      end

      it "silently ignores debug messages" do
        expect($stderr).not_to receive(:puts)
        ExpensiveMath.log(:debug, "debug message")
      end
    end
  end

  describe "LLMClient" do
    let(:mock_openai_client) { double("OpenAI::Client") }
    let(:client) { ExpensiveMath::LLMClient.new }

    before do
      ExpensiveMath.api_key = "test-key"
      # Mock OpenAI::Client to prevent actual API calls
      allow(OpenAI::Client).to receive(:new).and_return(mock_openai_client)
    end

    it "initializes with configured values" do
      expect(client.instance_variable_get(:@api_key)).to eq("test-key")
      expect(client.instance_variable_get(:@model)).to eq("gpt-3.5-turbo")
      expect(client.instance_variable_get(:@client)).to eq(mock_openai_client)
    end

    it "raises error when api_key is not configured" do
      ExpensiveMath.api_key = nil
      expect { client.calculate(:+, 2, 3) }.to raise_error(ExpensiveMath::Error, "API key not configured")
    end

    describe "calculate method" do
      let(:mock_response) do
        {
          "choices" => [
            {
              "message" => {
                "content" => "5"
              }
            }
          ]
        }
      end

      before do
        allow(mock_openai_client).to receive(:chat).and_return(mock_response)
        allow(ExpensiveMath).to receive(:log) # Mock logging to avoid output during tests
      end

      it "makes API call with correct parameters" do
        expect(mock_openai_client).to receive(:chat).with(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: "What is the sum of 2 and 3? Return the result as a single number." }],
            max_tokens: 50,
            temperature: 0
          }
        ).and_return(mock_response)

        result = client.calculate(:+, 2, 3)
        expect(result).to eq(5)
      end

      it "handles boolean responses for comparison operators" do
        bool_response = {
          "choices" => [
            {
              "message" => {
                "content" => "true"
              }
            }
          ]
        }
        allow(mock_openai_client).to receive(:chat).and_return(bool_response)

        result = client.calculate(:==, 2, 2)
        expect(result).to be true
      end

      it "handles spaceship operator responses" do
        spaceship_response = {
          "choices" => [
            {
              "message" => {
                "content" => "-1"
              }
            }
          ]
        }
        allow(mock_openai_client).to receive(:chat).and_return(spaceship_response)

        result = client.calculate(:<=>, 2, 3)
        expect(result).to eq(-1)
      end
    end

    describe "operator prompts" do
      it "has prompts for all mathematical operators" do
        expected_operators = [:+, :-, :*, :/, :%, :**, :==, :<, :>, :<=, :>=, :<=>]
        expect(ExpensiveMath::LLMClient::OPERATOR_PROMPTS.keys).to match_array(expected_operators)
      end

      it "builds correct prompts for basic operations" do
        prompts = client.send(:build_prompt, :+, 2, 3)
        expect(prompts).to eq("What is the sum of 2 and 3? Return the result as a single number.")
      end

      it "builds correct prompts for comparison operations" do
        prompts = client.send(:build_prompt, :==, 2, 3)
        expect(prompts).to eq("Are these two numbers equal: 2 and 3? Answer only 'true' or 'false'.")
      end

      it "builds correct prompts for power operations" do
        prompts = client.send(:build_prompt, :**, 2, 3)
        expect(prompts).to eq("What is the result of raising 2 to the power of 3? Return the result as a single number.")
      end
    end
  end

  describe "operator monkey patching" do
    let(:mock_openai_client) { double("OpenAI::Client") }

    before do
      # Mock OpenAI::Client to prevent actual API calls in monkey patched methods
      allow(OpenAI::Client).to receive(:new).and_return(mock_openai_client)
      allow(ExpensiveMath).to receive(:log) # Mock logging
    end

    it "patches numeric classes with expensive operators" do
      # Verify that original methods are aliased
      expect(Integer.instance_methods).to include(:original_+)
      expect(Float.instance_methods).to include(:original_*)
    end

    it "falls back to original method when LLM fails" do
      ExpensiveMath.api_key = nil # This will cause LLM to fail
      
      # Should fall back to original CPU calculation without raising errors
      expect { 2 + 3 }.not_to raise_error
      expect(2.original_+ 3).to eq(5) # Original method should still work
    end

    it "falls back to original method when LLM is configured but fails" do
      ExpensiveMath.api_key = "test-key"
      
      # Mock LLM failure by making the client raise an error
      allow(mock_openai_client).to receive(:chat).and_raise(StandardError.new("API error"))
      
      # Should fall back to original CPU calculation
      result = 3 + 5
      expect(result).to eq(8) # Original method result
    end
  end
end
