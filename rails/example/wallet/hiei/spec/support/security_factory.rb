FactoryGirl.define do
  factory :selic_2017, class: Security do
    name 'Tesouro Selic 2017'
    indexer_id 1
    yield_type :MONTHLY
    tax_type :FIXED_INCOME
    expiration DateTime.parse('2017-03-01')
  end
end
