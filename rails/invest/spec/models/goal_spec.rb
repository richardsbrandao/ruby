# frozen_string_literal: true
# == Schema Information
#
# Table name: goals
#
#  id                     :integer          not null, primary key
#  name                   :string
#  year                   :integer
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  amount_cents           :integer          default(0), not null
#  amount_currency        :string           default("BRL"), not null
#  monthly_input_cents    :integer          default(0), not null
#  monthly_input_currency :string           default("BRL"), not null
#


require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:goal_1) { create(:amount_goal) }
  let(:goal_2) { create(:amount_goal, name: 'Viagem') }

  before do
    tax = build(:default_tax)
    investiment_tesouro = build(:tesouro_direto, ir: tax)
    investiment_fundo_a = build(:fundo_a, ir: tax)

    sm_one = build(:saved_money, investiment: investiment_fundo_a)
    sm_two = build(:saved_money, amount: Money.new(200_000, 'BRL'), investiment: investiment_tesouro)

    create(:saved_money_percentage, goal: goal_1, value: 70, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_2, value: 30, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_1, saved_money: sm_two)
  end

  describe '#total' do
    subject { goal.total }

    context 'calculate total if there is more than one saved money' do
      let(:goal) { Goal.first }

      it { is_expected.to eq(Money.new(270_000, 'BRL')) }
    end

    context 'calculate totall if there is only one saved money' do
      let(:goal) { Goal.second }

      it { is_expected.to eq(Money.new(30_000, 'BRL')) }
    end
  end

  describe '#forecast' do
    let(:now) { '2017-06-01 00:00:00'.to_time }
    let(:goal) { Goal.first }
    let(:interest) { 8.5 }
    before { Timecop.travel(now) }

    subject { goal.forecast(interest, year) }

    context 'forecast for long time ahead' do
      let(:year) { 2030 }

      it { expect(subject.to_f).to eq(61_202_635.07133059) }
    end

    context 'forecast for same year' do
      let(:year) { now.year }

      it { expect(subject.to_f).to eq(1_503_131.8961480934) }
    end
  end
end
