# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestCalculator, type: :model do
  describe '#compound_interest_with_monthly_input' do
    let(:interest_calculator) { example }

    subject { interest_calculator.compound_interest_with_monthly_input }

    context 'compound interest with zero monthly input' do
      let(:example) { build(:interest_calculator, monthly_input: 0) }
      it { is_expected.to eq(1104.6221254112045) }
    end

    context 'compund interest with some monthly input' do
      let(:example) { build(:interest_calculator) }
      it { is_expected.to eq(2150.8433795232495) }
    end

    context 'compund interest test 2' do
      let(:example) { build(:interest_calculator, current_value: 20_000, monthly_input: 1290, period_number: 150, interest_rate: 0.006) }
      it { is_expected.to eq(361_454.4156800105) }
    end

    context 'compund interest test 3' do
      let(:example) { build(:interest_calculator, current_value: 0, period_number: 100) }
      it { is_expected.to eq(17_048.13829421528) }
    end

    context 'compund interest test 4' do
      let(:example) { build(:interest_calculator, period_number: 1) }
      it { is_expected.to eq(1110.0) }
    end

    context 'compund interest test 5' do
      let(:example) { build(:interest_calculator, period_number: 0) }
      it { is_expected.to eq(1000.0) }
    end

    context 'compund interest test 6' do
      let(:example) { build(:interest_calculator, current_value: 2_700, monthly_input: 2_000, period_number: 169, interest_rate: 0.007) }
      it { is_expected.to eq(651_841.8742541376) }
    end
  end
end
