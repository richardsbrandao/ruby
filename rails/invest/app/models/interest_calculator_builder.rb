class InterestCalculatorBuilder
	attr_reader :interest_calculator

	def initialize
		@interest_calculator = InterestCalculator.new
	end

	def current_value(current_value)
		@interest_calculator.current_value = current_value
		self 
	end

	def monthly_input(monthly_input)
		@interest_calculator.monthly_input = monthly_input
		self
	end

	def period_number_in_months(period_number)
		@interest_calculator.period_number = period_number
		self
	end

	def yearly_interest_rate(yearly_interest_rate)
		@interest_calculator.interest_rate = yearly_interest_rate / 12.0 / 100.0
		self
	end

	def interest_calculator
		raise ArgumentError if invalid_for_compound_interest_with_monthly_input?

		@interest_calculator
	end

	private

	def invalid_for_compound_interest_with_monthly_input?
		@interest_calculator.current_value.nil? || @interest_calculator.monthly_input.nil? &&
			@interest_calculator.period_number.nil? || @interest_calculator.interest_rate.nil?
	end
end