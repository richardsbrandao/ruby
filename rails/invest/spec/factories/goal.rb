# frozen_string_literal: true

FactoryGirl.define do
  factory :amount_goal, class: Amount do
    name 'Casa Propria'
    year 2023
    amount Money.new(40_000_000, 'BRL')
    monthly_input Money.new(200_000, 'BRL')

    initialize_with { new(attributes) }
  end

  factory :rent_goal, class: Amount do
    name 'Aposentadoria'
    year 2040
    value Money.new(600_000, 'BRL')
    monthly_input Money.new(150_000, 'BRL')

    initialize_with { new(attributes) }
  end
end
