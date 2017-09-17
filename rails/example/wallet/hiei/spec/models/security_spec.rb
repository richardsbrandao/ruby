require 'rails_helper'
require 'support/factory_girl.rb'
require 'support/security_factory.rb'

RSpec.describe Security, type: :model do
  describe 'valid?' do
    let(:security) { build(:selic_2017) }

    context 'is valid' do
      it 'with all properties' do
        expect(security.valid?).to be_truthy
      end

      it 'all tax_type possible properties' do
        security.tax_type = :FIXED_INCOME
        expect(security.valid?).to be_truthy
        security.tax_type = :NO_TAX
        expect(security.valid?).to be_truthy
        security.tax_type = :PRIVATE_SOCIAL_SECURITY
        expect(security.valid?).to be_truthy
        security.tax_type = :STOCK
        expect(security.valid?).to be_truthy
      end

      it 'all yield_type possible properties' do
        security.yield_type = :MONTHLY
        expect(security.valid?).to be_truthy
        security.yield_type = :DAILY
        expect(security.valid?).to be_truthy
        security.yield_type = :YEARLY
        expect(security.valid?).to be_truthy
      end
    end

    context 'is not valid' do
      it 'because name is empty' do
        security.name = nil
        expect(security.valid?).to be_falsey
        expect(security.errors.size).to eq(1)
      end

      it 'because indexer_id is empty' do
        security.indexer_id = nil
        expect(security.valid?).to be_falsey
        expect(security.errors.size).to eq(1)
      end

      it 'because yield_type is empty' do
        security.yield_type = nil
        expect(security.valid?).to be_falsey
        expect(security.errors.size).to eq(1)
      end

      it 'because tax_type is empty' do
        security.tax_type = nil
        expect(security.valid?).to be_falsey
        expect(security.errors.size).to eq(1)
      end

      it 'because expiration is empty' do
        security.expiration = nil
        expect(security.valid?).to be_falsey
        expect(security.errors.size).to eq(1)
      end

      it 'because yield_type is not valid' do
        expect { security.yield_type = :INVALIDO }.to raise_error(ArgumentError)
      end

      it 'because tax_type is not valid' do
        expect { security.tax_type = :INVALIDO }.to raise_error(ArgumentError)
      end
    end
  end
end
