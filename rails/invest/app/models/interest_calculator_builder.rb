# frozen_string_literal: true

class InterestCalculatorBuilder
  attr_reader :current_value, :monthly_input, :period_number, :interest_rate, :goal

  def with_current_value(current_value)
    @current_value = current_value if current_value.is_a? Money
    self
  end

  def with_monthly_input(monthly_input)
    @monthly_input = monthly_input if monthly_input.is_a? Money
    self
  end

  def with_period_number_in_months(period_number)
    @period_number = period_number if period_number.is_a? Numeric
    self
  end

  def with_yearly_interest_rate(yearly_interest_rate)
    @interest_rate = yearly_interest_rate / 12.0 / 100.0 if yearly_interest_rate.is_a? Numeric
    self
  end

  def with_goal(goal)
    @goal = goal if goal.is_a? Money
    self
  end

  def interest_discovery
    raise ArgumentError if invalid_for_interest_discovery?
    
    InterestDiscoveryCalculator.new({
      current_value: @current_value, monthly_input: @monthly_input,
      period_number: @period_number, goal: @goal
    })
  end

  def interest_calculator
    raise ArgumentError if invalid_for_compound_interest_with_monthly_input?

    CompoundInterestCalculator.new({
      current_value: @current_value, monthly_input: @monthly_input,
      period_number: @period_number, interest_rate: @interest_rate
    })
  end

  private

  def invalid_for_compound_interest_with_monthly_input?
    @current_value.nil? || @monthly_input.nil? || @period_number.nil? || @interest_rate.nil?
  end

  def invalid_for_interest_discovery?
    @current_value.nil? || @monthly_input.nil? || @period_number.nil? || @goal.nil?
  end
end
