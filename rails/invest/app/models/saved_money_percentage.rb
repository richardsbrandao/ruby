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

class SavedMoneyPercentage < ApplicationRecord
  belongs_to :saved_money
  belongs_to :goal

  def self.find_by_saved_money_and_goal(saved_money_id, goal_id)
    find_by(saved_money_id: saved_money_id, goal_id: goal_id)
  end
end
