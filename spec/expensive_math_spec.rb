RSpec.describe ExpensiveMath do
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

    it "has default values" do
      expect(ExpensiveMath.api_endpoint).to eq("https://api.openai.com/v1/chat/completions")
      expect(ExpensiveMath.model).to eq("gpt-3.5-turbo")
    end
  end
end
