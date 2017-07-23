# frozen_string_literal: true

module DashboardsHelper
  def goal_type_description(goal)
    return 'de Renda' if goal.is_a? Rent
    return 'Total' if goal.is_a? Amount
  end

  def forecast(goal)
    inflaction_rate = params[:inflaction_rate].present? ? params[:inflaction_rate] : RATES_CONFIG.dig('rates', 'inflaction')
    interest_rate = params[:interest_rate].present? ? params[:interest_rate] : RATES_CONFIG.dig('rates', 'interest')
    optimism_rate = params[:optimism_rate].present? ? params[:optimism_rate] : RATES_CONFIG.dig('rates', 'optimism')

  	(DateTime.now.year..goal.year).each.map do |year| 
  		{ 
  			year: year.to_s, 
  			inflaction: goal.forecast(inflaction_rate.to_f, year).cents / 100 ,
  			interest: goal.forecast(interest_rate.to_f, year).cents / 100 ,
  			optimism: goal.forecast(optimism_rate.to_f, year).cents / 100 ,
  		} 
  	end
  end
end
