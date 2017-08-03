# frozen_string_literal: true

FactoryGirl.define do
  factory :interest_discovery_calculator, class: InterestDiscoveryCalculator do
    current_value { Money.new(100_000) }
    monthly_input { Money.new(10_000) }
    period_number 15
    goal { Money.new(300_000) }

    initialize_with { new(attributes) }
  end
end
