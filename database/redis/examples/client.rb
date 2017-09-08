require 'redis'

redis = Redis.new(host: '127.0.0.1')

list = redis.client('list')
puts "LIST: #{list}"

setname = redis.client('setname', 'Richard')
puts "setname: #{setname}"

getname = redis.client('getname')
puts "getname: #{getname}"

redis.set('abc', '123')
abc_dump = redis.dump('abc')
puts "abc_dump = #{abc_dump}"