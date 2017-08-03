# frozen_string_literal: true

class CompoundInterestCalculator
  attr_reader :current_value, :monthly_input, :period_number, :interest_rate

  def initialize(params = {})
    @current_value = params.fetch(:current_value)
    @monthly_input = params.fetch(:monthly_input)
    @period_number = params.fetch(:period_number)
    @interest_rate = params.fetch(:interest_rate)
  end

  def compound_interest_with_monthly_input
    Money.new(@current_value.cents * (1 + @interest_rate)**@period_number + @monthly_input.cents * ((1 + @interest_rate)**@period_number - 1) / @interest_rate)
  end
end
