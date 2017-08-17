Variation.all.each do |variation|
  puts "Removendo Variation{#{variation.id}}"
  variation.destroy
end

Security.all.each do |security|
  puts "Removendo Security{#{security.id}}"
  security.destroy
end

Indexer.all.each do |indexer|
  puts "Removendo Indexer{#{indexer.id}}"
  indexer.destroy
end

indexers = [
  ['SELIC', 'Taxa de Juros Básica da Economia', [[2014, 11, 1.04], [2014, 12, 1.04], [2015, 1, 1.12]]],
  ['IPCA', 'Indice de Inflação', [[2014, 11, 0.81], [2014, 12, 0.41], [2015, 1, 1.32]]],
  ['CDI', 'Certificados de Depósito Interbancário', []]
]

indexers.each do |indexer|
  createdIndexer = Indexer.new(name: indexer[0], description: indexer[1])
  indexer[2].each do |variation|
    createdIndexer.variations << Variation.new(year: variation[0], month: variation[1], percent: variation[2])
  end

  createdIndexer.save
  puts "Indexer{#{createdIndexer.id}} criado"
end

selic = Indexer.find_by(name: 'SELIC')
ipca = Indexer.find_by(name: 'IPCA')

tesouro_selic = Security.new(name: 'Tesouro SELIC 2017', indexer_id: selic.id, tax_type: :FIXED_INCOME, expiration: Date.parse('2017-03-01'), yield_type: :DAILY)
tesouro_selic.save
puts "Criado #{tesouro_selic.name}{#{tesouro_selic.id}}"

tesouro_ipca = Security.new(name: 'Tesouro IPCA 2019', indexer_id: ipca.id, tax_type: :FIXED_INCOME, expiration: Date.parse('2019-01-03'), yield_type: :DAILY)
tesouro_ipca.save
puts "Criado #{tesouro_ipca.name}{#{tesouro_ipca.id}}"
