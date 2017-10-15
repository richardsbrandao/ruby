class Router
	def initialize(request)
		@request = request
	end

	def context
		app_context[@request.path]
	end

	def app_context
		{
			'/' => [CustomersController, 'index'],
			'/customers' => [CustomersController, 'index'],
			'/orders' => [OrdersController, 'index']
		}
	end
end