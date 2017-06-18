# frozen_string_literal: true

FactoryGirl.define do
  factory :interest_calculator, class: InterestCalculator do
    current_value 1000
    monthly_input 100
    period_number 10
    interest_rate 0.01

    # initialize_with { new(attributes) }
  end
end
