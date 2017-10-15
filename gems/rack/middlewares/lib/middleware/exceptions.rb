class Exceptions
	def initialize(app)
		@app = app
	end

	def call(env)
		@app.call(env)
	rescue Rack::Timeout::RequestTimeoutError => e
		Rack::Response.new(e.message, 504)
	rescue => e
		puts "Loggin Exception number #{e.message} "
		Rack::Response.new('Deu Xabru!', 500)
	end
end