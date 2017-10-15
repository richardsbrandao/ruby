require 'controllers/customers_controller'
require 'controllers/orders_controller'
require 'middleware/router'

class OrderApplication
	def initialize(env)
		@request = Rack::Request.new(env)
	end

	def self.call(env)
		new(env).response.finish
	end

	def response
		controller, method = Router.new(@request).context
		Rack::Response.new(controller.new.send(method))
	end
end
