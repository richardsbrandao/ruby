require 'redis'
require 'date'

room_name = ARGV[0]

$redis = Redis.new(host: 'services')

class Room 
	def initialize(room)
		@room = room
		@connections = 0
	end

	def receive_message(message)
		join_room(message) if message.join?
		exit_command(message) if message.exit?
		show_message(message) if message.show?
	end

	private

	def exit_command(message)
		@connections = @connections - 1
		puts "#{message.author} left #{@room} room"
		$redis.unsubscribe if @connections == 0
	end

	def show_message(message)
		puts "#{message.author} - #{message.content}"
	end

	def join_room(message)
		@connections = @connections + 1
		puts "#{message.author} joined #{@room} room"
	end
end

class Message
	attr_reader :author, :content

	def self.from(message)
		author, content = message.split(':', 2)
		return JoinMessage.new(author, content) if content.eql? 'join'
		return ExitMessage.new(author, content) if content.eql? 'exit'
		return ShowMessage.new(author, content)
	end

	def initialize(author, content)
		@author, @content = author, content
	end
end

class JoinMessage < Message
	def join?
		true
	end

	def show?
		false
	end

	def exit?
		false
	end
end

class ShowMessage < Message
	def join?
		false
	end

	def show?
		true
	end

	def exit?
		false
	end
end

class ExitMessage < Message
	def join?
		false
	end

	def show?
		false
	end

	def exit?
		true
	end
end

room = Room.new(room_name)

begin
	$redis.subscribe(room_name) do |on|
		on.subscribe do |channel, subscriptions|
			puts "Channel created: #{channel} (#{subscriptions})"
		end

		on.message do |channel, message|
			room.receive_message(Message.from(message))

			# puts "Message on #{channel}: #{message}"
			# redis_unsubscribe if message.end_with? 'exit'
		end	

		on.unsubscribe do |channel, subscriptions| 
			puts "Channel ended #{channel} (#{subscriptions})"
		end
	end
rescue Redis::BaseConnectionError => e
	puts "#{e}, retrying in 1s"
	sleep 1
	retry
end