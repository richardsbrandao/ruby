# frozen_string_literal: true
# == Schema Information
#
# Table name: saved_money_percentages
#
#  id             :integer          not null, primary key
#  value          :integer
#  saved_money_id :integer
#  goal_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#


require 'rails_helper'

RSpec.describe SavedMoneyPercentage, type: :model do
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

  describe 'scopes' do
    describe '#find_by_saved_money_and_goal' do
      subject { SavedMoneyPercentage.find_by(saved_money: saved_money_id, goal: 1) }

      context 'find by goal and saved_money' do
        let(:saved_money_id) { 1 }
        it { is_expected.to be_kind_of(SavedMoneyPercentage) }
      end

      context 'return nil if does not exist' do
        let(:saved_money_id) { 999_999 }
        it { is_expected.to be_nil }
      end
    end
  end
end
