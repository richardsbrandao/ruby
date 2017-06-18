# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SavedMoney, type: :model do
  let(:goal_1) { create(:amount_goal) }
  let(:goal_2) { create(:amount_goal, name: 'Viagem') }

  before do
    tax = build(:default_tax)
    investiment_tesouro = build(:tesouro_direto, ir: tax)
    investiment_fundo_a = build(:fundo_a, ir: tax)

    sm_one = build(:saved_money, investiment: investiment_fundo_a)
    sm_two = build(:saved_money, value: BigDecimal.new(2_000), investiment: investiment_tesouro)

    create(:saved_money_percentage, goal: goal_1, value: 70, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_2, value: 30, saved_money: sm_one)
    create(:saved_money_percentage, goal: goal_1, saved_money: sm_two)
  end

  describe '#for_goal' do
    subject { SavedMoney.for_goal(goal_id) }

    context 'all saved money for specific goal' do
      let(:goal_id) { goal_1.id }
      it { expect(subject.size).to eq(2) }
      it { expect(subject.first.value).to eq(1_000) }
      it { expect(subject.second.value).to eq(2_000) }
    end

    context 'no saved money for invalid goal' do
      let(:goal_id) { 999_999 }
      it { is_expected.to be_empty }
    end
  end

  describe '#amount_per_goal' do
    subject { saved_money_example.amount_per_goal(goal_id) }
    let(:goal_id) { goal_1.id }

    context 'calculate amount per goal when its divided in percentage' do
      let(:saved_money_example) { SavedMoney.first }

      it { is_expected.to eq(700) }
    end

    context 'calculate amount per goal when its not divided (100%)' do
      let(:saved_money_example) { SavedMoney.second }

      it { is_expected.to eq(2000) }
    end

    context 'calculate amount per invalid goal' do
      let(:saved_money_example) { SavedMoney.first }
      let(:goal_id) { 999_999 }

      it { expect(subject).to eq(0) }
    end
  end
end
