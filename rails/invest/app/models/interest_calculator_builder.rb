class InterestCalculatorBuilder
	attr_reader :interest_calculator

	def initialize
		@interest_calculator = InterestCalculator.new
	end

	def current_value(current_value)
		@interest_calculator.current_value = current_value if current_value.is_a? Numeric
		self 
	end

	def monthly_input(monthly_input)
		@interest_calculator.monthly_input = monthly_input if monthly_input.is_a? Numeric
		self
	end

	def period_number_in_months(period_number)
		@interest_calculator.period_number = period_number if period_number.is_a? Numeric
		self
	end

	def yearly_interest_rate(yearly_interest_rate)
		@interest_calculator.interest_rate = yearly_interest_rate / 12.0 / 100.0 if yearly_interest_rate.is_a? Numeric
		self
	end

	def interest_calculator
		raise ArgumentError if invalid_for_compound_interest_with_monthly_input?

		@interest_calculator
	end

	private

	def invalid_for_compound_interest_with_monthly_input?
		@interest_calculator.current_value.nil? || @interest_calculator.monthly_input.nil? ||
			@interest_calculator.period_number.nil? || @interest_calculator.interest_rate.nil?
	end
end