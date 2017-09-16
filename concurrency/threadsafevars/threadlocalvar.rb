require 'concurrent'

v = Concurrent::ThreadLocalVar.new(14)

puts "Start app - #{v.value}"


t1 = Thread.new do
  v.value
  puts "t1 context - #{v.value}"
  v.value = 1
  puts "t1 context after attribution - #{v.value}"
  v.value
end

t2 = Thread.new do
  v.value
  puts "t2 context - #{v.value}"
  v.value = 2
  puts "t2 context after attribution - #{v.value}"
  v.value
end

v.value
puts "Out scope after code declaration- #{v.value}"

sleep 1