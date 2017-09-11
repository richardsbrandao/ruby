require 'redis'

name = ARGV[0]
room = ARGV[1]
$redis = Redis.new(host: 'services')

$redis.publish(room, "#{name}:join")

def out_command?(msg) 
	msg.eql?('exit')
end

def get_and_publish(name, room)
	msg = STDIN.gets.chomp
	$redis.publish(room, "#{name}:#{msg}")
	msg
end

puts "Hello #{name.upcase} you are in #{room.upcase} room"
msg = get_and_publish(name, room)

while ! out_command?(msg) do    
	msg = get_and_publish(name, room)
end