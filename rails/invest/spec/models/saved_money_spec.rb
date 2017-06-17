require 'rails_helper'

RSpec.describe SavedMoney, type: :model do
	describe '#for_goal' do
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
	end
end
