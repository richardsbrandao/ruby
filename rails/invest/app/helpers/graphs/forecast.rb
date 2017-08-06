module Graphs
  module Forecast
    def forecast(goal)
      objective_rate = goal.amount_cents

      (DateTime.now.year..goal.year).each.map do |year| 
        { 
          year: year.to_s, 
          inflaction: goal.forecast(inflaction_rate.to_f, year).cents / 100 ,
          interest: goal.forecast(interest_rate.to_f, year).cents / 100 ,
          optimism: goal.forecast(optimism_rate.to_f, year).cents / 100,
          goal_line: goal.forecast(goal.goal_line_forecast(year).to_f, year).cents / 100
        } 
      end
    end

    private

    def inflaction_rate
      params[:inflaction_rate].present? ? params[:inflaction_rate] : RATES_CONFIG.dig('rates', 'inflaction')
    end

    def interest_rate
      params[:interest_rate].present? ? params[:interest_rate] : RATES_CONFIG.dig('rates', 'interest')
    end

    def optimism_rate
      params[:optimism_rate].present? ? params[:optimism_rate] : RATES_CONFIG.dig('rates', 'optimism')
    end
  end
end