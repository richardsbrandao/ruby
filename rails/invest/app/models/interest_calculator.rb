# frozen_string_literal: true

class InterestCalculator
  attr_accessor :current_value, :monthly_input, :period_number, :interest_rate

  def compound_interest_with_monthly_input
    @current_value * (1 + @interest_rate)**@period_number + @monthly_input * ((1 + @interest_rate)**@period_number - 1) / @interest_rate
  end
end
