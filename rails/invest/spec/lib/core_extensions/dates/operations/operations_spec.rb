# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dates::Operations do
  describe '#DateTime.diff_in_months_from_now' do
    let(:current_year) { 2017 }
    let(:current_month) { 5 }
    let(:new_now) { Time.local(current_year, current_month, 1, 0, 0, 0) }

    subject { DateTime.now.diff_in_months_from_now("#{future_year}-12-31 00:00:00".to_time) }

    before { Timecop.travel(new_now) }

    context 'diff in same year' do
      let(:future_year) { current_year }

      it { is_expected.to eq(7) }
    end

    context 'diff in another year' do
      let(:future_year) { 2019 }

      it { is_expected.to eq(31) }
    end

    context 'diff in another year in the past' do
      let(:future_year) { 2016 }

      it { is_expected.to eq(-5) }
    end
  end
end
