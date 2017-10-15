require './order_application'
require 'middleware/exceptions'

use Rack::Reloader, 0

use Rack::Auth::Basic do |username, password|
	password == 'admin' && username == 'admin'
end
use Exceptions

# Default in Env
run OrderApplication

# Run With Puma
# require "rack/handler/puma"
# Rack::Handler::Puma.run OrderApplication

# Run With Thin
Rack::Handler::Thin.run OrderApplication