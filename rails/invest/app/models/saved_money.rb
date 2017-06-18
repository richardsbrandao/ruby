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

class SavedMoney < ApplicationRecord
  monetize :amount_cents, :as => 'amount'
  belongs_to :investiment
  has_many :saved_money_percentages

  scope :for_goal, ->(goal_id) { joins(:saved_money_percentages).where('saved_money_percentages.goal_id': goal_id) }

  def amount_per_goal(goal_id)
    saved_money_percentage = SavedMoneyPercentage.find_by(saved_money: id, goal: goal_id)
    return 0 if saved_money_percentage.blank?
    value.percentage_of(saved_money_percentage.value)
  end
end
