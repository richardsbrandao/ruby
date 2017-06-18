require 'rails_helper'

RSpec.describe Goal, type: :model do
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

	describe '#total' do
		subject { goal.total }

		context 'calculate total if there is more than one saved money' do
			let(:goal) { Goal.first }

			it { is_expected.to eq(2700) }
		end

		context 'calculate totall if there is only one saved money' do 
			let(:goal) { Goal.second }

			it { is_expected.to eq(300) }
		end

	end

	describe '#forecast' do
		let(:now) { "2017-06-01 00:00:00".to_time }
		let(:goal) { Goal.first }
		let(:interest) { 8.5 }
		before { Timecop.travel(now) }

		subject { goal.forecast(interest, year) }

		context 'forecast for long time ahead' do
			let(:year) { 2030 }

			it { expect(subject.to_f).to eq(612026.3507133059) }
		end

		context 'forecast for same year' do
			let(:year) { now.year }

			it { expect(subject.to_f).to eq(15031.318961480934) }
		end
	end
end
