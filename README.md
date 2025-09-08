# ExpensiveMath 💸

The most expensive way to do basic math! Why use efficient CPU operations when you can make API calls to large language models for simple arithmetic?

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'expensive-math'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install expensive-math

## Configuration

Before using ExpensiveMath, you need to configure your LLM API credentials:

```ruby
require 'expensive_math'

ExpensiveMath.configure do |config|
  config.api_key = 'your-openai-api-key'
  config.api_endpoint = 'https://api.openai.com/v1/chat/completions'  # default
  config.model = 'gpt-3.5-turbo'  # default
end
```

## Usage

Once configured, all mathematical operations on numbers will automatically use LLM calls:

```ruby
require 'expensive_math'

# Configure your API key first
ExpensiveMath.configure do |config|
  config.api_key = ENV['OPENAI_API_KEY']
end

# Now every math operation costs money! 💰
result = 2 + 3        # Makes an API call to calculate 2 + 3
puts result           # => 5 (eventually, and expensively)

# All operators are supported:
puts 10 - 4           # Subtraction via LLM
puts 6 * 7            # Multiplication via LLM  
puts 15 / 3           # Division via LLM
puts 2 ** 8           # Exponentiation via LLM
puts 17 % 5           # Modulo via LLM
```

## Features

- ✅ Replaces all basic mathematical operators with LLM API calls
- ✅ Supports addition, subtraction, multiplication, division, exponentiation, and modulo
- ✅ Works with integers and floats
- ✅ Configurable LLM endpoint and model
- ✅ Guaranteed to be slower and more expensive than regular math
- ✅ Perfect for burning through your API quota

## Why?

Great question! Here are some compelling reasons to use ExpensiveMath:

1. **Cost Optimization**: Why spend $0.00 on CPU cycles when you can spend $0.002 per calculation?
2. **Latency Enhancement**: Transform microsecond operations into multi-second adventures
3. **Carbon Footprint Maximization**: Ensure your simple arithmetic contributes to global warming
4. **Dependency Injection**: Add network dependencies to the most basic operations
5. **Debugging Complexity**: Turn `2 + 2 = 4` into a distributed systems problem
6. **Rate Limiting Fun**: Experience the joy of being throttled while calculating your grocery bill

## Error Handling

ExpensiveMath includes robust error handling for when your math goes wrong:

```ruby
begin
  result = 5 + 3
rescue ExpensiveMath::Error => e
  puts "Math failed: #{e.message}"
  # Fallback to regular math? Never!
end
```

## Performance

Here's a performance comparison:

| Operation | Regular Ruby | ExpensiveMath | Cost Increase |
|-----------|--------------|---------------|---------------|
| 2 + 2     | 0.001ms      | 500-2000ms    | 500,000x - 2,000,000x |
| 10 * 5    | 0.001ms      | 500-2000ms    | 500,000x - 2,000,000x |
| API Cost  | $0.00        | ~$0.002       | ∞ |

## Contributing

Bug reports and pull requests are welcome! Please ensure all mathematical operations remain as inefficient as possible.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Disclaimer

This gem is intended for educational and entertainment purposes. Please don't actually use this in production unless you enjoy explaining to your boss why your calculator app has a $10,000 monthly API bill.

---

*"Making simple things complicated since 2024"* - ExpensiveMath Team
