# frozen_string_literal: true

# == Schema Information
#
# Table name: saved_moneys
#
#  id             :integer          not null, primary key
#  value          :decimal(8, 2)
#  date           :datetime
#  investiment_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class SavedMoney < ApplicationRecord
  belongs_to :investiment
  has_many :saved_money_percentages

  scope :for_goal, ->(goal_id) { joins(:saved_money_percentages).where('saved_money_percentages.goal_id': goal_id) }

  def amount_per_goal(goal_id)
    saved_money_percentage = SavedMoneyPercentage.find_by(saved_money: id, goal: goal_id)
    return 0 if saved_money_percentage.blank?
    value.percentage_of(saved_money_percentage.value)
  end
end
