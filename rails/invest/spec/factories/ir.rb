# frozen_string_literal: true

FactoryGirl.define do
  factory :default_tax, class: Ir do
    tax 'PADRAO'

    initialize_with { new(attributes) }
  end

  factory :income_tax, class: Ir do
    tax 'INCOME'

    initialize_with { new(attributes) }
  end
end
