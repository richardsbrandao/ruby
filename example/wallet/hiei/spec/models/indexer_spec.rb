require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/indexer_factory.rb'

RSpec.describe Indexer, type: :model do
  let(:indexer) { build(:selic) }

  it 'must have variations and name' do
    indexer.variations << Variation.new

    expect(indexer.name).to eq('SELIC')
    expect(indexer.description).to eq('Taxa de Juros')
    expect(indexer.variations.size).to eq(1)
  end

  it 'must validate a indexer with all fields' do
    expect(indexer.valid?).to be_truthy
  end

  it 'must validate a indexer without description' do
    indexer.description = nil
    expect(indexer.valid?).to be_truthy
  end

  it 'must not validate a indexer without name' do
    indexer.name = nil
    expect(indexer.valid?).to be_falsey
  end
end
