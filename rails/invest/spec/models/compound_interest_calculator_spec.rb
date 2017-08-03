# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompoundInterestCalculator, type: :model do
  describe '#compound_interest_with_monthly_input' do
    let(:interest_calculator) { example }

    subject { interest_calculator.compound_interest_with_monthly_input }

    context 'compound interest with zero monthly input' do
      let(:example) { build(:compound_interest_calculator, monthly_input: Money.new(0)) }
      it { is_expected.to eq(Money.new(110_462.21254112045)) }
    end

    context 'compund interest with some monthly input' do
      let(:example) { build(:compound_interest_calculator) }
      it { is_expected.to eq(Money.new(215_084.33)) }
    end

    context 'compund interest test 2' do
      let(:example) { build(:compound_interest_calculator, current_value: Money.new(2_000_000), monthly_input: Money.new(129_000), period_number: 150, interest_rate: 0.006) }
      it { is_expected.to eq(Money.new(36_145_441.56)) }
    end

    context 'compund interest test 3' do
      let(:example) { build(:compound_interest_calculator, current_value: Money.new(0), period_number: 100) }
      it { is_expected.to eq(Money.new(1_704_813.82)) }
    end

    context 'compund interest test 4' do
      let(:example) { build(:compound_interest_calculator, period_number: 1) }
      it { is_expected.to eq(Money.new(111_000.00)) }
    end

    context 'compund interest test 5' do
      let(:example) { build(:compound_interest_calculator, period_number: 0) }
      it { is_expected.to eq(Money.new(100_000.0)) }
    end

    context 'compund interest test 6' do
      let(:example) { build(:compound_interest_calculator, current_value: Money.new(270_000), monthly_input: Money.new(200_000), period_number: 169, interest_rate: 0.007) }
      it { is_expected.to eq(Money.new(65_184_187.42)) }
    end
  end
end
