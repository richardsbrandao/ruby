require 'rails_helper'

RSpec.describe Numbers::Operations do
	describe '#BigDecimal.percentage_of' do
		let(:percentage_of) { 2 }

		subject { BigDecimal.new(200).percentage_of(percentage_of) }

		context 'some percentage of' do
			it { is_expected.to eq(4) }
		end

		context 'percentage of zero' do
			let(:percentage_of) { 0 }

			it { is_expected.to eq(0) }
		end

		context 'percentage of negative number' do
			let(:percentage_of) { -1 }

			it { is_expected.to eq(-2) } 
		end
	end
end
