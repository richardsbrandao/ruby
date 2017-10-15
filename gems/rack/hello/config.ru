class Hello
	def call(env)
		# [200, {'Content-Type' => 'text/plain'}, ['hello world!']]
		Rack::Response.new("Hello World! #{env['puma.config'].environment}")
	end
end

run Hello.new