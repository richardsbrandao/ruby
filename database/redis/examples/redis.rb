require 'redis'
require 'date'

redis = Redis.new(host: 'services')
#redis = Redis.new(host: "10.0.1.1", port: 6380, db: 15)

puts 'FLUSHALL'
redis.flushall

redis.set("hello", "world")
puts 'SET[hello] = world'

get = redis.get('hello')
puts "GET[hello] = #{get}"

redis.del('hello')
puts 'DEL[hello]'
get = redis.get('hello')
puts "GET[hello] = #{get}"

puts "10.times { INCR[VALUE] }"
10.times do 
	redis.incr('VALUE')
end
value = redis.get('VALUE')
puts "GET[hello] = #{value}"

puts "20.times { DECR[VALUE] }"
20.times do 
	redis.decr('VALUE')
end
value = redis.get('VALUE')
puts "GET[VALUE] = #{value}"

# Retorna NIL se a chave nao existir ou OLD_VALUE se a chave existir
today = redis.getset('TODAY', Time.now.to_i)
puts "GETSET[TODAY] = #{today}"



# DECRBY
# INCRYBY
# Append
# KEYS
# KLEN
# EXISTS
# GETRANGE






# Client List
# Client GETNAME
# Client SETNAME
# DBSIZE
# DUMP

# GEOADD
# GEOHASH
# GEOPOS
# GEODIST

# EXPIRE
# EXPIREAT
# FLUSHALL

# HDEL
# HEXISTS
# HGET
# HGETALL
# HINCRBY
# HEYS
# HSET
# HVALS
