# frozen_string_literal: true

# Patch numeric classes with expensive operators at load time
# Two-phase approach: first alias all originals, then define all overrides
[Integer, Float, Rational, Complex].each do |klass|
  klass.class_eval do
    # Phase 1: Alias all original methods first
    operators_to_patch = []
    ExpensiveMath::LLMClient::OPERATOR_PROMPTS.each_key do |operator|
      next unless klass.instance_methods.include?(operator)
      
      original_method = "original_#{operator}".to_sym
      alias_method original_method, operator
      operators_to_patch << operator
    end

    # Phase 2: Define all overrides after all originals are safely aliased
    operators_to_patch.each do |operator|
      original_method = "original_#{operator}".to_sym
      
      define_method(operator) do |other|
        return send(original_method, other) unless ExpensiveMath.enabled?

        begin
          original_proc = proc { send(original_method, other) }
          ExpensiveMath::LLMClient.new.calculate(operator, self, other, original_proc)
        rescue ExpensiveMath::Error => e
          ExpensiveMath.log(:warn, "LLM failed (#{e.message}), falling back to CPU calculation")
          send(original_method, other)
        end
      end
    end
  end
end
