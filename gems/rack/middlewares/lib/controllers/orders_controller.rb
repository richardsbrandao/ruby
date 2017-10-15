class OrdersController
	def index
		random = Random.rand(10)
		if random < 7
			'orders'
		else
			raise StandardError.new(random)
		end
	end
end