class ApplicationGuard
	def call_logging
		puts ">> Start Guard #{self.class}"
		result = do_call
		puts "<< End Guard  #{self.class} result #{result}"

		result
	end

	alias call call_logging
end

class AuthorizeGuard < ApplicationGuard
	def initialize(payment)
		@payment = payment
	end

	def do_call
		puts "Authorizing #{@payment.to_s}"
		authorize!
	end

	def authorize!
		authorized = Random.rand(10) < 7
		@payment.errors << 'Authorized Error' unless authorized
		authorized
	end
end

class CheckErrorGuard < ApplicationGuard
	def initialize(payment)
		@payment = payment
	end

	def do_call
		puts "check_error #{@payment.to_s}"
		true
	end
end

class ConfirmGuard < ApplicationGuard
	def initialize(payment)
		@payment = payment
	end

	def do_call
		puts "Confirming #{@payment.to_s}"
		confirm!
	end

	def confirm!
		confirmed = Random.rand(10) < 7
		@payment.errors << 'Confirmed Error' unless confirmed
		confirmed
	end
end

class ClearCvv < ApplicationGuard
	def initialize(payment)
		@payment = payment
	end

	def do_call
		puts "Cleaning Cvv"
		@payment.cvv = nil
	end
end

class SavePayment < ApplicationGuard
	def initialize(payment)
		@payment = payment
	end

	def do_call
		puts "SavePayment in Database with state '#{@payment.aasm.to_state}'"
	end
end