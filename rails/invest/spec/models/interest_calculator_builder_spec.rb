# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestCalculatorBuilder, type: :model do
  describe '#interest_calculator' do
    let(:total) { Money.new(1000) }
    let(:monthly_input) { Money.new(100) }
    let(:months) { 12 }
    let(:interest) { 10.20 }

    subject do
      InterestCalculatorBuilder.new.with_current_value(total).with_monthly_input(monthly_input)
                               .with_period_number_in_months(months).with_yearly_interest_rate(interest)
                               .interest_calculator
    end

    context 'successfuly build' do
      it { is_expected.to be_kind_of(CompoundInterestCalculator) }
    end

    [nil, 'string'].each do |invalid_value|
      context "error when current_value is #{invalid_value.inspect}" do
        let(:total) { invalid_value }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "error when monthly_input is #{invalid_value.inspect}" do
        let(:monthly_input) { invalid_value }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "error when period_number_in_months is #{invalid_value.inspect}" do
        let(:months) { invalid_value }
        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context "error when yearly_interest_rate is #{invalid_value.inspect}" do
        let(:interest) { invalid_value }
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end

    describe '#interest_discovery' do
      let(:total) { Money.new(1000) }
      let(:monthly_input) { Money.new(100) }
      let(:months) { 12 }
      let(:goal) { Money.new(10000) }

      subject do
        InterestCalculatorBuilder.new.with_current_value(total).with_monthly_input(monthly_input)
                            .with_period_number_in_months(months).with_goal(goal)
                            .interest_discovery
      end

      context 'successfuly build' do
        it { is_expected.to be_kind_of(InterestDiscoveryCalculator) }
      end

      [nil, 'string'].each do |invalid_value|
        context "error when current_value is #{invalid_value.inspect}" do
          let(:total) { invalid_value }
          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context "error when monthly_input is #{invalid_value.inspect}" do
          let(:monthly_input) { invalid_value }
          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context "error when period_number_in_months is #{invalid_value.inspect}" do
          let(:months) { invalid_value }
          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context "error when goal is #{invalid_value.inspect}" do
          let(:goal) { invalid_value }
          it { expect { subject }.to raise_error(ArgumentError) }
        end
      end
    end
  end
end
