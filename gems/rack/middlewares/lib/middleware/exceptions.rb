class Exceptions
	def initialize(app)
		@app = app
	end

	def call(env)
		@app.call(env)
	rescue => e
		puts "Loggin Exception number #{e.message} "
		Rack::Response.new('Deu Xabru!', 500)
	end
end