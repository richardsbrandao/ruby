# frozen_string_literal: true

FactoryGirl.define do
  factory :compound_interest_calculator, class: CompoundInterestCalculator do
    current_value { Money.new(100_000) }
    monthly_input { Money.new(10_000) }
    period_number 10
    interest_rate 0.01

    initialize_with { new(attributes) }
  end
end
