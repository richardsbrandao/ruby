# frozen_string_literal: true

module DashboardsHelper
  def goal_type_description(goal)
    return 'de Renda' if goal.is_a? Rent
    return 'Total' if goal.is_a? Amount
  end

  def forecast(goal)
  	(DateTime.now.year..goal.year).each.map do |year| 
  		{ year: year.to_s, forecast: goal.forecast(10, year).cents / 100 } 
  	end
  end
end
