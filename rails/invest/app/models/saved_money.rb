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
  monetize :amount_cents, as: 'amount'
  belongs_to :investiment
  has_many :saved_money_percentages

  scope :for_goal, ->(goal_id) { joins(:saved_money_percentages).where('saved_money_percentages.goal_id': goal_id) }

  def self.cached_all_with_percentages
  	Rails.cache.fetch("all_percentages") do
  		SavedMoney.includes(:saved_money_percentages).all.order(:date)
  	end
  end

  def amount_per_goal
    saved_money_percentage = saved_money_percentages.detect { |saved_money_percentage| saved_money_percentage.saved_money.id == id } 
    return Money.new(0, amount_currency) if saved_money_percentage.blank?
    Money.new(amount_cents.percentage_of(saved_money_percentage.value), amount_currency)
  end
end
