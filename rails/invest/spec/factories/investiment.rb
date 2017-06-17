FactoryGirl.define do
	factory :tesouro_direto, class: Investiment do
		name 'TESOURO SELIC'
		model 'RENNDA_FIXA'
		year_yield 10.25
		ir { nil }

	    initialize_with { new(attributes) }
	end

	factory :fundo_a, class: Investiment do
		name 'FUNDO DE INVESTIMENTO A'
		model 'RENNDA_FIXA'
		year_yield 12.35
		ir { nil }

	    initialize_with { new(attributes) }
	end
end