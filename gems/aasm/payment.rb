require 'aasm'
require 'securerandom' 
require './guards'

class Payment
	attr_reader :value, :credit_card_token, :owner
	attr_accessor :cvv, :errors

	def initialize(params)
		@value = params.fetch(:value)
		@credit_card_token = params.fetch(:credit_card_token)
		@cvv = params.fetch(:cvv)
		@owner = params.fetch(:owner)
		@errors = []
	end

	include AASM
	aasm do
		state :created, initial: true
		state :authorized, :unauthorized, :confirmed, :cancelled 
		state :refunded_error, :refunded

		event :authorizing do
			transitions :from => :created, :to => :authorized, guard: AuthorizeGuard, :after => [ClearCvv, SavePayment]
			transitions :from => :created, :to => :unauthorized, guard: CheckErrorGuard, :after => [ClearCvv, SavePayment]
		end

		event :confirming do
			transitions :from => :authorized, :to => :confirmed, guard: ConfirmGuard, :after => SavePayment
			transitions :from => :authorized, :to => :cancelled, guard: CheckErrorGuard, :after => SavePayment
		end

		event :refunding do 
			transitions :from => :confirmed, :to => :refunded
			transitions :from => :confirmed, :to => :refunded_error
		end
	end

	def to_s
		"owner[#{@owner}}] value[#{@value}] credit_card_token[#{@credit_card_token}] errors[#{@errors}]"
	end
end

payment = Payment.new(value: 30, cvv: 123, credit_card_token: SecureRandom.uuid, owner: 'Richard')

puts "created? #{payment.created?}"

payment.authorizing
puts "authorized? #{payment.authorized?}"
puts "unauthorized? #{payment.unauthorized?}"

if payment.authorized?
	payment.confirming
	puts "confirmed? #{payment.confirmed?}"
	puts "cancelled? #{payment.cancelled?}"
end
