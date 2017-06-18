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
  monetize :amount_cents, :as => 'amount'
  monetize :monthly_input_cents, :as => 'monthly_input'

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
