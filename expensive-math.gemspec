require_relative "lib/expensive_math/version"

Gem::Specification.new do |spec|
  spec.name          = "expensive-math"
  spec.version       = ExpensiveMath::VERSION
  spec.authors       = ["Steve Craig"]

  spec.summary       = "The most expensive way to do basic math"
  spec.description   = "Why use efficient CPU operations when you can make API calls to large language models for simple arithmetic? This gem replaces all mathematical operators with LLM calls, making every calculation delightfully slow and expensive."
  spec.homepage      = "https://github.com/yourusername/expensive-math"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yourusername/expensive-math"
  spec.metadata["changelog_uri"] = "https://github.com/yourusername/expensive-math/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies for making HTTP requests to LLM APIs
  spec.add_dependency "ruby-openai", "~> 7.0"

  # Development dependencies
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "climate_control", "~> 1.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
end
