# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_moneys
#
#  id              :integer          not null, primary key
#  date            :datetime
#  investiment_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("BRL"), not null
#

require 'rails_helper'

RSpec.describe SavedMoney, type: :model do
  let(:default_currency) { 'BRL' }
  let(:goal_1) { create(:amount_goal) }
  let(:goal_2) { create(:amount_goal, name: 'Viagem') }

  before do
    tax = build(:default_tax)
    investiment_tesouro = build(:tesouro_direto, ir: tax)
    investiment_fundo_a = build(:fundo_a, ir: tax)

    sm_one = build(:saved_money, investiment: investiment_fundo_a)
    sm_two = build(:saved_money, amount: Money.new(200_000, default_currency), investiment: investiment_tesouro)

    create(:saved_money_percentage, goal: goal_1, value: 70, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_2, value: 30, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_1, saved_money: sm_two)
  end

  describe '#for_goal' do
    subject { SavedMoney.for_goal(goal_id) }

    context 'all saved money for specific goal' do
      let(:goal_id) { goal_1.id }
      it { expect(subject.size).to eq(2) }
      it { expect(subject.first.amount).to eq(Money.new(100_000)) }
      it { expect(subject.second.amount).to eq(Money.new(200_000, default_currency)) }
    end

    context 'no saved money for invalid goal' do
      let(:goal_id) { 999_999 }
      it { is_expected.to be_empty }
    end
  end

  describe '#amount_per_goal' do
    subject { saved_money_example.amount_per_goal }

    context 'calculate amount per goal when its divided in percentage' do
      let(:saved_money_example) { SavedMoney.first }

      it { is_expected.to eq(Money.new(70_000, default_currency)) }
    end

    context 'calculate amount per goal when its not divided (100%)' do
      let(:saved_money_example) { SavedMoney.second }

      it { is_expected.to eq(Money.new(200_000, default_currency)) }
    end
  end
end
