Investiment.all.each { |model| model.destroy }
IndexValue.all.each { |model| model.destroy }
Index.all.each { |model| model.destroy }
SavedMoneyPercentage.all.each { |model| model.destroy }
SavedMoney.all.each { |model| model.destroy }
Ir.all.each { |model| model.destroy }
Amount.all.each { |model| model.destroy }
Rent.all.each { |model| model.destroy }

Index.create([
	{name: 'SELIC'},
	{name: 'IPCA'},
	{name: 'CDI'}
])

IndexValue.create([
	{period: '2017-05', value: 10.25/12, index: Index.first},
	{period: '2017-05', value: 0.31, index: Index.second},
	{period: '2017-05', value: 10.13/12, index: Index.third}
])

Ir.create([
	{tax: 'FREE'},
	{tax: 'INCOME'}
])

Amount.create([
	{name: 'Europa', year: 2019, value: 30_000, monthly_input: 1000}
])

Rent.create([
	{name: 'Aposentadoria', year: 2041, value: 6_000, monthly_input: 1000}
])

Investiment.create([
	{name: 'Tesouro SELIC', model: 'RENNDA_FIXA', ir: Ir.second, year_yield: 10.25},
	{name: 'Gap Multiport FIM', model: 'FUNDO', ir: Ir.second, year_yield: 13.00},
	{name: 'AZ Quest Total Return FIM', model: 'FUNDO', ir: Ir.second, year_yield: 12.50}
])

SavedMoney.create([
	{value: 6000.0, date: "2017-05-10 00:00:00".to_time, investiment: Investiment.third},
	{value: 6300.0, date: "2017-05-10 00:00:00".to_time, investiment: Investiment.second},
	{value: 22_467.63, date: "2017-05-31 00:00:00".to_time, investiment: Investiment.first}
])

SavedMoneyPercentage.create([
	{value: 100, saved_money: SavedMoney.third, goal: Amount.first},
	{value: 70, saved_money: SavedMoney.second, goal: Amount.first},
	{value: 30, saved_money: SavedMoney.second, goal: Rent.first},
	{value: 70, saved_money: SavedMoney.first, goal: Amount.first},
	{value: 30, saved_money: SavedMoney.first, goal: Rent.first}
])