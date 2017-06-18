# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestCalculatorBuilder, type: :model do
  describe '#interest_calculator' do
    let(:total) { 1000 }
    let(:monthly_input) { 100 }
    let(:months) { 12 }
    let(:interest) { 10.20 }

    subject do
      InterestCalculatorBuilder.new.current_value(total).monthly_input(monthly_input)
                               .period_number_in_months(months).yearly_interest_rate(interest)
                               .interest_calculator
    end

    context 'successfuly build' do
      it { is_expected.to be_kind_of(InterestCalculator) }
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
  end
end
