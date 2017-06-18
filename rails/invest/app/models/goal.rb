# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id            :integer          not null, primary key
#  name          :string
#  year          :integer
#  value         :integer
#  monthly_input :decimal(, )
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Goal < ApplicationRecord
  has_many :saved_money_percentages

  def total
    SavedMoney.for_goal(id).reduce(0) { |sum, saved_money| saved_money.amount_per_goal(id) + sum }.to_f
  end

  def forecast(interest, year)
    months = DateTime.now.diff_in_months_from_now("#{year}-12-31 00:00:00".to_time)
    InterestCalculatorBuilder.new.current_value(total).monthly_input(monthly_input)
                             .period_number_in_months(months).yearly_interest_rate(interest)
                             .interest_calculator.compound_interest_with_monthly_input
  end
end
