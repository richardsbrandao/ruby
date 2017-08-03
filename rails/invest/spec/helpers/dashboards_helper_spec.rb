# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsHelper do
  let(:dashboard_helper) { Class.new { include DashboardsHelper } }

  describe '#goal_type_description' do
    subject { dashboard_helper.new.goal_type_description(goal) }

    context 'when goal is a Rent class' do
      let(:goal) { Rent.new }
      it { expect(subject).to eq('de Renda') }
    end

    context 'when goal is a Amount class' do
      let(:goal) { Amount.new } 
      it { expect(subject).to eq('Total') }
    end
  end

  describe '#forecast' do
    subject { dashboard_helper.new.forecast(goal) }

    let(:goal) { create(:amount_goal, monthly_input: Money.new(0, 'BRL')) }
    let(:new_now) { Time.local(current_year, current_month, 1, 0, 0, 0) }

    before do 
      allow_any_instance_of(DashboardsHelper).to receive(:inflaction_rate).and_return(4)
      allow_any_instance_of(DashboardsHelper).to receive(:interest_rate).and_return(7)
      allow_any_instance_of(DashboardsHelper).to receive(:optimism_rate).and_return(10)

      Timecop.travel(new_now) 
    end

    before do
      tax = build(:default_tax)
      investiment_tesouro = build(:tesouro_direto, ir: tax)
      investiment_fundo_a = build(:fundo_a, ir: tax)

      sm_one = build(:saved_money, investiment: investiment_fundo_a)
      sm_two = build(:saved_money, amount: Money.new(200_000, 'BRL'), investiment: investiment_tesouro)

      create(:saved_money_percentage, goal: goal, saved_money: sm_one)
      create(:saved_money_percentage, goal: goal, saved_money: sm_two)
    end

    context 'in same year' do
      let(:current_year) { 2023 } 
      let(:current_month) { 3 }

      it { expect(subject.size).to eq(1) }

      it { expect(subject.first[:year]).to eq('2023') } 
      it { expect(subject.first[:inflaction]).to eq(3_091) }
      it { expect(subject.first[:interest]).to eq(3_161) }
      it { expect(subject.first[:optimism]).to eq(3_232) }
      it { expect(subject.first[:goal_line]).to eq(6165) }
    end

    context 'for 5 years' do
      let(:goal) { create(:amount_goal, monthly_input: Money.new(500_000, 'BRL')) }
      let(:current_year) { 2019 } 
      let(:current_month) { 5 }

      it { expect(subject.size).to eq(5) } 

      it { expect(subject.first[:year]).to eq('2019') } 
      it { expect(subject.first[:inflaction]).to eq(38422) }
      it { expect(subject.first[:interest]).to eq(38743) }
      it { expect(subject.first[:optimism]).to eq(39066) }
      it { expect(subject.first[:goal_line]).to eq(39640) }

      it { expect(subject.second[:year]).to eq('2020') } 
      it { expect(subject.second[:inflaction]).to eq(101100) }
      it { expect(subject.second[:interest]).to eq(103506) }
      it { expect(subject.second[:optimism]).to eq(105985) }
      it { expect(subject.second[:goal_line]).to eq(110502) }

      it { expect(subject.third[:year]).to eq('2021') } 
      it { expect(subject.third[:inflaction]).to eq(166331) }
      it { expect(subject.third[:interest]).to eq(172952) }
      it { expect(subject.third[:optimism]).to eq(179911) }
      it { expect(subject.third[:goal_line]).to eq(192960) }

      it { expect(subject.fourth[:year]).to eq('2022') } 
      it { expect(subject.fourth[:inflaction]).to eq(234220) }
      it { expect(subject.fourth[:interest]).to eq(247417) }
      it { expect(subject.fourth[:optimism]).to eq(261578) }
      it { expect(subject.fourth[:goal_line]).to eq(288909) }

      it { expect(subject.fifth[:year]).to eq('2023') } 
      it { expect(subject.fifth[:inflaction]).to eq(304875) }
      it { expect(subject.fifth[:interest]).to eq(327266) }
      it { expect(subject.fifth[:optimism]).to eq(351796) }
      it { expect(subject.fifth[:goal_line]).to eq(400559) }
    end
  end
end
