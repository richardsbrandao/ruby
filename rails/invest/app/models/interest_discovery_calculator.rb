# frozen_string_literal: true

class InterestDiscoveryCalculator
  attr_reader :current_value, :monthly_input, :period_number, :interest_rate

  def initialize(params = {})
    @current_value = params.fetch(:current_value)
    @monthly_input = params.fetch(:monthly_input)
    @period_number = params.fetch(:period_number)
    @goal = params.fetch(:goal)
  end

  def find_yearly_interest_with_monthly_input
    interest = 0
    byebug
    while interest < RATES_CONFIG.dig('rates', 'max') do
      interest = increase_interest(interest)
      estimate_value = compound_interest_with_monthly_input(interest)
      return interest if estimate_value.cents > @goal.cents
    end
    byebug
    RATES_CONFIG.dig('rates', 'max')
  end

  private

  def increase_interest(interest)
    (interest || 0) + 0.25
  end

  def compound_interest_with_monthly_input(interest_rate)
    InterestCalculatorBuilder.new.with_current_value(@current_value)
                            .with_monthly_input(@monthly_input)
                            .with_period_number_in_months(@period_number)
                            .with_yearly_interest_rate(interest_rate)
                            .interest_calculator
                            .compound_interest_with_monthly_input
  end
end
