require './order_application'
require 'middleware/exceptions'

use Rack::Reloader, 0

use Rack::Auth::Basic do |username, password|
	password == 'admin' && username == 'admin'
end
use Exceptions

run OrderApplication