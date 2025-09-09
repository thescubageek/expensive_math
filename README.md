# ExpensiveMath 💸

**ExpensiveMath is the most inefficient, unnecessary, environmentally destructive, and absurdly expensive way to do basic math!**

Are you...

- Tired of your calculator app finishing calculations in nanoseconds?
- Frustrated by the complete lack of network latency in basic arithmetic?
- Wanting to watch an infinite loop cost more than the GDP of Luxembourg?
- Needing to turn `2 + 2` into a distributed systems architecture challenge?
- Excited about the chance to break your Ruby environment on a fundamental level?
- 

### ExpensiveMath is here to solve these problems!

Why use efficient CPU operations when you can leverage **cutting-edge AI technology** to **disrupt the status quo of basic arithmetic?** 

This isn't just math - it's **AI-powered mathematical intelligence as a service**! We're **democratizing computation** by making every addition operation a **scalable, cloud-native, machine learning experience**. 

With the power of **generative AI**, you can extend your mathematic operations runtime by over a **staggering 100 MILLION PERCENT! This is the future of math, bro - we're not just doing calculations, we're **building the next generation of intelligent computational workflows**.

Perfect for developers who think their math operations aren't nearly **expensive, slow, or carbon-intensive enough**. Finally, a way to make your calculator app require an internet connection and a monthly subscription to OpenAI!

## Features

- ✅ Replaces all basic mathematical operators with OpenAI API calls
- ✅ Supports addition, subtraction, multiplication, division, exponentiation, and modulo
- ✅ Supports comparison operators
- ✅ Works with integers, floats, rationals, and complex numbers
- ✅ Configurable LLM endpoint and model
- ✅ Dry run mode for testing without API calls or costs
- ✅ Guaranteed to be slower and more expensive than regular math
- ✅ Perfect for burning through your API quota
- ✅ Racks up hundreds or thousands of dollars in API calls within minutes just from loading the gem and running basic Ruby code
- ✅ Might cost you your job, spouse, kids, and home

## Why?

Great question! Here are some compelling reasons to use ExpensiveMath:

1. **Cost Optimization**: Why spend $0.00 on CPU cycles when you can spend $0.002 per calculation?
2. **Latency Enhancement**: Transform microsecond operations into multi-second adventures
3. **Carbon Footprint Maximization**: Ensure your simple arithmetic contributes to global warming
4. **Dependency Injection**: Add network dependencies to the most basic operations
5. **Debugging Complexity**: Turn `2 + 2 = 4` into a distributed systems problem
6. **Rate Limiting Fun**: Experience the joy of being throttled while calculating your grocery bill

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'expensive-math'
```

And then execute:
```bash
bundle install
```

Or install it yourself as:
```bash
gem install expensive-math
```

Congrats, now your Ruby core now prepared to destroy your bank account doing trivial math!

## Unintallation

**Trust me, you're going to want to do this.** Remove this line from your application's Gemfile:

```ruby
gem 'expensive-math'
```

And then execute:
```bash
bundle install
```

Or uninstall it yourself as:
```bash
gem uninstall expensive-math
```

You're welcome!

## Configuration

Before using ExpensiveMath, you need to configure your **[OpenAI API key](https://platform.openai.com/api-keys)**:

```ruby
require 'expensive_math'

ExpensiveMath.configure do |config|
  config.api_key = 'your-openai-api-key'
  config.api_endpoint = 'https://api.openai.com/v1/chat/completions'  # default
  config.model = 'gpt-5-nano'  # default
  config.dry_run = false  # default - set to true for testing without API calls
end
```

View **[OpenAI's pricing](https://openai.com/pricing)** to choose how quickly you want to go into crippling debt.

## Usage

ExpensiveMath requires explicit activation to avoid accidentally breaking your Ruby environment:

```ruby
require 'expensive_math'

# Configure your API key first
ExpensiveMath.configure do |config|
  config.api_key = ENV['OPENAI_API_KEY']
  config.dry_run = false  # Set to true for testing without API calls
end

# IMPORTANT: You must explicitly activate expensive math!
ExpensiveMath.activate!

# Now every math operation costs money! 💰
result = 2 + 3        # Makes an API call to calculate 2 + 3
puts result           # => 5 (eventually, and expensively)

# All operators are supported:
puts 10 - 4           # Subtraction via LLM
puts 6 * 7            # Multiplication via LLM  
puts 15 / 3           # Division via LLM
puts 2 ** 8           # Exponentiation via LLM
puts 17 % 5           # Modulo via LLM
puts 5 == 5           # Equality comparison via LLM
puts 3 < 7            # Less than comparison via LLM
puts 8 > 2            # Greater than comparison via LLM
puts 4 <= 4           # Less than or equal via LLM
puts 9 >= 6           # Greater than or equal via LLM
puts 5 <=> 3          # Spaceship operator via LLM

# Disable expensive math when you're done or you'll run out of money!
ExpensiveMath.deactivate!
```

See the [Dry Run Mode](#dry-run-mode) section for more information if you want to preview the cost and performance impact of your math operations without actually making API calls or requiring an API key.

### Safely Testing Locally (Dry Run Mode)

The "safest" way to test ExpensiveMath is in dry run mode, which lets you see what operations would be sent to the LLM without actually making API calls or requiring an API key:

```shell
irb -I lib -r expensive_math
```

Then in IRB:
```ruby
require 'expensive_math'

# Configure dry run mode (no API key needed!)
ExpensiveMath.configure do |config|
  config.dry_run = true
  config.logger = Logger.new(STDOUT)  # Optional: see logs
end

# Activate expensive math
ExpensiveMath.activate!

# Operations will log what they would do but use normal Ruby math
puts 2 + 3  # Logs: "DRY RUN: What is the sum of 2 and 3?" → 5
puts 10 * 5 # Logs: "DRY RUN: What is the product of 10 and 5?" → 50

# Check dry run status
puts ExpensiveMath.dry_run?  # => true

# Disable when done
ExpensiveMath.deactivate!
```

**Dry run features:**
- ✅ Works only when ExpensiveMath is activated
- ✅ No API key required
- ✅ Logs intended operations for debugging
- ✅ Returns correct mathematical results using normal Ruby operations
- ✅ Perfect for testing integration without API costs

### Unleash Hell 🔥💸

Ready to **completely obliterate your bank account** and turn your blazing-fast Ruby application into a **sluggish, network-dependent nightmare**? Here's how to activate **full GPT mode** and watch your finances evaporate in real-time:

```ruby
require 'expensive_math'

# Step 1: Configure your soon-to-be-empty wallet
ExpensiveMath.configure do |config|
  config.api_key = ENV['OPENAI_API_KEY']  # Your financial doom awaits
  config.dry_run = false                  # 🚨 DANGER ZONE: Real API calls ahead!
  config.model = 'gpt-4'                  # Why not use the MOST expensive model?
  config.logger = Logger.new(STDOUT)      # Watch your money disappear in real-time
end

# Step 2: Activate the financial apocalypse
ExpensiveMath.activate!

# Step 3: Enjoy watching simple math operations cost more than your coffee
puts 2 + 2          # 💸 $0.002 and 3 seconds later... => 4
puts 10 * 5         # 💸 Another $0.002 and 3 more seconds... => 50
puts 100 / 4        # 💸 Your API quota is crying... => 25

# Step 4: For maximum financial destruction, try some loops!
(1..10).each { |i| puts i + 1 }  # 💸💸💸 $0.02 and 30 seconds of pure inefficiency

# Step 5: Don't forget to deactivate... if you remember... if you can afford to...
ExpensiveMath.deactivate!  # Your wallet will thank you (what's left of it)
```

**Congratulations!** You've successfully:
- 🔥 Transformed microsecond operations into multi-second adventures
- 💸 Converted free CPU cycles into expensive API calls
- 🌍 Maximized your carbon footprint with every addition
- 📈 Created the world's most inefficient calculator
- 🎯 Achieved peak software engineering excellence

**Pro tip:** For maximum chaos, forget to call `deactivate!` and watch as **every mathematical operation in your entire Ruby application** becomes a network request. Your production logs will look like a DDoS attack, but it's just your app trying to calculate `array.length + 1`.

### Activation Control

```ruby
# Enable expensive math
ExpensiveMath.activate!
puts 2 + 3  # 💸 Uses LLM (or dry run)

# Disable expensive math
ExpensiveMath.deactivate!
puts 2 + 3  # ✅ Uses normal Ruby math (= 5)

# Check status
puts ExpensiveMath.activated?  # => false
```

### Safety Features

- **Opt-in activation**: Simply requiring the gem won't break your Ruby environment
- **Dry run mode**: Preview how awful this gem is before you pay for it
- **Graceful fallback**: If API calls fail, operations fall back to normal CPU calculations
- **No API key required**: Without an API key, all operations use normal Ruby math

## Running Tests

To run the test suite:

```bash
# Run all specs
bundle exec rspec

# Run specs with verbose output
bundle exec rspec --format documentation

# Run a specific test file
bundle exec rspec spec/expensive_math_spec.rb

# Run specs and see coverage
bundle exec rspec --format progress
```

The test suite runs in dry run mode by default, so no API key is required for testing.

### Estimation Rake Task

ExpensiveMath includes a convenient rake task for estimating the cost and performance impact of mathematical expressions without actually making API calls:

#### Single Expression Analysis

```bash
rake expensive_math:estimate['2 + 3 * 4']
```

This will output detailed analysis including:
- Operation count detection
- Estimated API cost
- Estimated execution time
- Performance comparison with regular Ruby

#### Multiple Expression Analysis

You can analyze multiple expressions at once using semicolon delimiters:

#### Simple Expression
```bash
rake expensive_math:estimate['2 + 3']
```

**Output:**
```
Processing 1 expressions: ["2 + 3"]
📊 Comparison Table:
| Expression | Operations | Regular Ruby | ExpensiveMath | Time Increase | Cost |
|------------|------------|--------------|---------------|---------------|------|
| 2 + 3      | 1          | 0.0029ms     | 1820ms        | 62,658,517%   | $0.000002 |
```

#### Multiple Moderate Expressions
```bash
rake expensive_math:estimate['5 * 7 - 1; (10 / 2) + 3; 2 ** 3 % 5']
```

**Output:**
```
Processing 3 expressions: ["5 * 7 - 1", "(10 / 2) + 3", "2 ** 3 % 5"]
📊 Comparison Table:
| Expression | Operations | Regular Ruby | ExpensiveMath | Time Increase | Cost |
|------------|------------|--------------|---------------|---------------|------|
| 5 * 7 - 1  | 2          | 0.0035ms     | 3640ms        | 103,957,043%  | $0.000004 |
| (10 / 2) + 3 | 2          | 0.0041ms     | 3728ms        | 90,926,729%   | $0.000004 |
| 2 ** 3 % 5 | 3          | 0.0058ms     | 5547ms        | 95,637,831%   | $0.000006 |
```

#### Complex Expressions with Comparisons
```bash
rake expensive_math:estimate['(2 + 3) * 4 != 20; 10 / 2 + 3 * 4 >= 17; (5 ** 2 - 10) <= (3 + 4) * 2']
```

**Output:**
```
Processing 3 expressions: ["(2 + 3) * 4 != 20", "10 / 2 + 3 * 4 >= 17", "(5 ** 2 - 10) <= (3 + 4) * 2"]
📊 Comparison Table:
| Expression | Operations | Regular Ruby | ExpensiveMath | Time Increase | Cost |
|------------|------------|--------------|---------------|---------------|------|
| (2 + 3) * 4 !... | 3          | 0.0038ms     | 5547ms        | 145,973,584%  | $0.000006 |
| 10 / 2 + 3 * ... | 4          | 0.0046ms     | 5472ms        | 118,956,422%  | $0.000008 |
| (5 ** 2 - 10)... | 5          | 0.006ms      | 4140ms        | 68,999,900%   | $0.00001 |
```

**Key Observations:**
- Each operation costs ~$0.000002
- Regular Ruby operations execute in microseconds (0.003-0.006ms)
- ExpensiveMath operations take thousands of milliseconds (3-6 seconds each)
- Time increases range from 69 million% to 146 million% slower than regular Ruby
- Inequality operators like `!=` leverage the expensive `==` implementation
- Complex expressions with 5+ operations can cost over $0.00001 per calculation

The rake task automatically runs in dry run mode, so no API key is required and no actual API calls are made.

## Error Handling

ExpensiveMath automatically handles failures gracefully to ensure your application continues running (albeit expensively):

1. **Built-in Retry Logic**: Each operator includes exponential backoff retry mechanisms that attempt the LLM call multiple times, maximizing both latency and API costs before giving up.

2. **Automatic Fallback**: When LLM calls fail after retries, operations automatically fall back to the original Ruby math operators that were preserved during monkey patching. This ensures your app doesn't crash - it just continues being brutally slow and expensive.

3. **Transparent Recovery**: The fallback happens seamlessly within each operator call, so your code continues executing without manual error handling. You get the "best" of both worlds: maximum inefficiency when possible, basic functionality when necessary.

## Contributing

Bug reports and pull requests are welcome! Please ensure all mathematical operations remain as inefficient as possible.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Disclaimer

This gem is intended for educational and entertainment purposes only. Please don't actually use this in production unless you enjoy explaining to your boss why your calculator app has a $100,000 monthly API bill. The author is not responsible for any performance issues or financial damage caused by the use of this gem -- enjoy the lulz but don't be a moron.

![And It's Gone](assets/and-its-gone.png)

---

*"Making simple things complicated since 2025"* - ExpensiveMath Team
