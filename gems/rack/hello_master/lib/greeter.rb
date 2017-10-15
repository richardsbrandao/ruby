require 'erb'

class Greeter
	def initialize(env)
		@request = Rack::Request.new(env)
	end

	def self.call(env)
		new(env).response.finish
	end

	def response
		case @request.path
		when '/' then Rack::Response.new(render('index.html.erb'))
		when '/set_name' then 
			Rack::Response.new do |response|
				response.set_cookie('name', @request.params['name'])
				response.redirect('/')
			end
		else respond_404
		end
	end

	private

	def render(template)
		path = File.expand_path("../views/#{template}", __FILE__)
		ERB.new(File.read(path)).result(binding)
	end

	def respond_404
		path = File.expand_path("../views/404.html", __FILE__)
		Rack::Response.new(File.read(path), 404)
	end

	def hello_name
		@request.cookies['name'] || 'World'
	end
end