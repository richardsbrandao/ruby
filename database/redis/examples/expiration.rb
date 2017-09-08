require 'redis'
require 'date'

redis = Redis.new(host: '127.0.0.1')

redis.set('company', 'github')
redis.expire('company', 5)

while true
	value = redis.get('company')
	ttl = redis.ttl('company')
	puts "#{value} - #{ttl} ttl"
	sleep 1
	break if value.nil?
end


redis.set('another_company', 'atlassian')
redis.expireat('another_company', (Time.now + 10).to_i) # 10 seconds

while true
	value = redis.get('another_company')
	ttl = redis.ttl('another_company')
	puts "#{value} - #{ttl} ttl"
	sleep 1
	break if value.nil?
end
