require 'redis'

redis = Redis.new(host: '127.0.0.1')

puts 'FLUSHALL'
redis.flushall

hset_return = redis.hset('richard', 'age', 25)
puts "HSET[richard][age]=25 = #{hset_return}"
redis.hset('richard', 'last_name', 'Brandão')
redis.hset('richard', 'gender', 'M')

puts "HGET[richard][age]"
redis.hget('richard', 'age')
puts "HGET[richard][last_name]"
redis.hget('richard', 'last_name')

hexists_richard = redis.hexists('richard', 'age')
puts "HEXISTS[richard][age] = #{hexists_richard}"
hexists_nao_existe = redis.hexists('richard', 'nao_existe')
puts "HEXISTS[richard][age] = #{hexists_nao_existe}"
exists_richard = redis.exists('richard')
puts "EXISTS[richard] = #{exists_richard}"
not_exists = redis.exists('nao_existe')
puts "EXISTS[richard] = #{not_exists}"

# HDEL
# HSETNX
# HGETALL


# HINCRBY

# HKEYS
# HVALS

# HMGET
# HMSET
