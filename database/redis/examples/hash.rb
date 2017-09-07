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

richard_hash = redis.hgetall('richard')
puts "HGETALL[richard] = #{richard_hash}"

hexists_richard = redis.hexists('richard', 'age')
puts "HEXISTS[richard][age] = #{hexists_richard}"
hexists_nao_existe = redis.hexists('richard', 'nao_existe')
puts "HEXISTS[richard][age] = #{hexists_nao_existe}"
exists_richard = redis.exists('richard')
puts "EXISTS[richard] = #{exists_richard}"
not_exists = redis.exists('nao_existe')
puts "EXISTS[richard] = #{not_exists}"

hdel = redis.hdel('richard', 'age')
puts "HDEL[richard][age] = #{hdel}"
hexists_richard = redis.hexists('richard', 'age')
puts "HEXISTS[richard][age] = #{hexists_richard}"

hsetnx_first = redis.hsetnx('ketherin', 'age', 26)
hsetnx_second = redis.hsetnx('ketherin', 'age', 1000)
puts "HSETNX[ketherin][age] = #{hsetnx_first}"
puts "HSETNX[ketherin][age] = #{hsetnx_second}"
ketherin_hash = redis.hgetall('ketherin')
puts "HGETALL[ketherin] = #{ketherin_hash}"


hkeys_richard = redis.hkeys('richard')
hvals_richard = redis.hvals('richard')
puts "HKEYS[richard] = #{hkeys_richard}"
puts "HVALS[richard] = #{hvals_richard}"


hmget = redis.hmget('richard', 'age', 'gender')
puts "HMGET[richard]{age, gender} = #{hmget}"
hmset = redis.hmset('richard', 'marital_status', 'MARRIED', 'zipcode', '21341140')
richard_hash = redis.hgetall('richard')
puts "HGETALL[richard] = #{richard_hash}"

hincrby = redis.hincrby('ketherin', 'age', 3)
puts "HINCRBY[ketherin][age]+3 = #{hincrby}"