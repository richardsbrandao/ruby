# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestDiscoveryCalculator, type: :model do
  describe '#find_yearly_interest_with_monthly_input' do
    let(:interest_calculator) { example }

    subject { interest_calculator.find_yearly_interest_with_monthly_input }

    context 'discovery interest rate with some monthly input' do
      let(:example) { build(:interest_discovery_calculator) }

      it { is_expected.to eq(21.25) }
    end

    context 'discovery interest rate without monthly input' do
      let(:example) { build(:interest_discovery_calculator, monthly_input: Money.new(0), goal: Money.new(120_000)) } 

      it { is_expected.to eq(14.75) }
    end

    context 'discovery interest rate with montly input and unreacheable goal go until 100% discovery' do
      let(:example) { build(:interest_discovery_calculator, goal: Money.new(1_000_000)) } 

      it { is_expected.to eq(100) }
    end

    context 'discovery 0 for interest rate if goal is less than amount' do
      let(:example) { build(:interest_discovery_calculator, goal: Money.new(1_000)) } 

      it { is_expected.to eq(0) }
    end
  end
end
