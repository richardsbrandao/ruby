# frozen_string_literal: true

FactoryGirl.define do
  factory :amount_goal, class: Amount do
    name 'Casa Propria'
    year 2023
    value 400_000
    monthly_input 2_000

    initialize_with { new(attributes) }
  end

  factory :rent_goal, class: Amount do
    name 'Aposentadoria'
    year 2040
    value 6_000
    monthly_input 1_500

    initialize_with { new(attributes) }
  end
end
