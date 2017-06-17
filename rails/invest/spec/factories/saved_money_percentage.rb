FactoryGirl.define do
	factory :saved_money_percentage, class: SavedMoneyPercentage do
		value 100
		saved_money { nil }
		goal { nil }

	    initialize_with { new(attributes) }
	end
end