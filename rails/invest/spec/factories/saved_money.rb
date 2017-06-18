# frozen_string_literal: true

FactoryGirl.define do
  factory :saved_money, class: SavedMoney do
    value BigDecimal.new(1000)
    date DateTime.now
    investiment { nil }

    initialize_with { new(attributes) }
  end
end
