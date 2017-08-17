FactoryGirl.define do
  factory :ipca, class: Indexer do
    name 'IPCA'
    description 'Indice oficial de Inflação no Brasil'
  end

  factory :selic, class: Indexer do
    name 'SELIC'
    description 'Taxa de Juros'
  end

  factory :cdi, class: Indexer do
    name 'CDI'
  end
end
