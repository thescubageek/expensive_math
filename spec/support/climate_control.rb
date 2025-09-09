# frozen_string_literal: true

require 'climate_control'

module EnvHelper
  def with_modified_env(options, &block)
    ClimateControl.modify(options, &block)
  end

  def with_expensive_math_enabled(&block)
    with_modified_env(EXPENSIVE_MATH_ENABLED: 'true', &block)
  end

  def with_expensive_math_disabled(&block)
    with_modified_env(EXPENSIVE_MATH_ENABLED: 'false', &block)
  end
end

RSpec.configure do |config|
  config.include(EnvHelper)
end
