# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestCalculator, type: :model do
  describe '#compound_interest_with_monthly_input' do
    let(:interest_calculator) { example }

    subject { interest_calculator.compound_interest_with_monthly_input }

    context 'compound interest with zero monthly input' do
      let(:example) { build(:interest_calculator, monthly_input: Money.new(0)) }
      it { is_expected.to eq(110462.21254112045) }
    end

    context 'compund interest with some monthly input' do
      let(:example) { build(:interest_calculator) }
      it { is_expected.to eq(215084.33795232498) }
    end

    context 'compund interest test 2' do
      let(:example) { build(:interest_calculator, current_value: Money.new(2_000_000), monthly_input: Money.new(129_000), period_number: 150, interest_rate: 0.006) }
      it { is_expected.to eq(361_45441.56800105) }
    end

    context 'compund interest test 3' do
      let(:example) { build(:interest_calculator, current_value: Money.new(0), period_number: 100) }
      it { is_expected.to eq(1704813.8294215284) }
    end

    context 'compund interest test 4' do
      let(:example) { build(:interest_calculator, period_number: 1) }
      it { is_expected.to eq(111000.00000000001) }
    end

    context 'compund interest test 5' do
      let(:example) { build(:interest_calculator, period_number: 0) }
      it { is_expected.to eq(100000.0) }
    end

    context 'compund interest test 6' do
      let(:example) { build(:interest_calculator, current_value: Money.new(270_000), monthly_input: Money.new(200_000), period_number: 169, interest_rate: 0.007) }
      it { is_expected.to eq(65_184_187.42541375) }
    end
  end
end
