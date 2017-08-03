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

class Goal < ApplicationRecord
  monetize :amount_cents, as: 'amount'
  monetize :monthly_input_cents, as: 'monthly_input'

  has_many :saved_money_percentages

  def total
    Rails.cache.fetch("total_goal_#{id}") do
      SavedMoney.for_goal(id).includes(:saved_money_percentages).reduce(0) { |sum, saved_money| saved_money.amount_per_goal + sum }
    end
  end

  def forecast(interest, year)
    months = DateTime.now.diff_in_months_from_now("#{year}-12-31 00:00:00".to_time)
    InterestCalculatorBuilder.new.with_current_value(total).with_monthly_input(monthly_input)
                             .with_period_number_in_months(months).with_yearly_interest_rate(interest)
                             .interest_calculator.compound_interest_with_monthly_input
  end

  def goal_line_forecast(year)
    months = DateTime.now.diff_in_months_from_now("#{self.year}-12-31 00:00:00".to_time)
    # estimate_value = InterestCalculatorBuilder.new.with_current_value(total).with_monthly_input(monthly_input)
    #                            .with_period_number_in_months(months).with_yearly_interest_rate(interest)
    #                            .interest_discovery.compound_interest_with_monthly_input
    interest = 2.00
    while interest < 1020 do
      interest = interest + 0.25
      estimate_value = InterestCalculatorBuilder.new.with_current_value(total).with_monthly_input(monthly_input)
                               .with_period_number_in_months(months).with_yearly_interest_rate(interest)
                               .interest_discovery.compound_interest_with_monthly_input
      puts "#{estimate_value} <<"
      return estimate_value if estimate_value.cents > self.amount_cents
    end

  end

  def self.cached_all
    Rails.cache.fetch('all_goals') { Goal.all }
  end
end
