module ExpensiveMath
  module Operators
    # Override operators for all numeric types
    def self.patch_numeric_classes!
      [Integer, Float, Rational, Complex].each do |klass|
        klass.class_eval do
          ExpensiveMath::LLMClient::OPERATOR_PROMPTS.each_key do |operator|
            # Store original method
            original_method = "original_#{operator}".to_sym
            alias_method original_method, operator
            
            define_method(operator) do |other|
              begin
                ExpensiveMath::LLMClient.new.calculate(operator, self, other)
              rescue ExpensiveMath::Error => e
                # Fallback to original method if LLM fails
                ExpensiveMath.log(:warn, "LLM failed (#{e.message}), falling back to CPU calculation")
                send(original_method, other)
              end
            end
          end
        end
      end
    end
  end
end

# Automatically patch numeric classes when the module is loaded
ExpensiveMath::Operators.patch_numeric_classes!
