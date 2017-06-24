# frozen_string_literal: true

FactoryGirl.define do
  factory :saved_money, class: SavedMoney do
    amount { Money.new(100_000, 'BRL') }
    date DateTime.now
    investiment { nil }

    initialize_with { new(attributes) }
  end
end
