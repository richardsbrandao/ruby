require 'concurrent'

def next_fibonacci(set = nil)
  return [0, 1] if set.nil?
  set + [set[-2..-1].reduce{|sum,x| sum + x }]
end

set = nil
7.times do
  set = next_fibonacci(set)
end
puts set

puts '--------------'

agent = Concurrent::Agent.new(next_fibonacci)
6.times do
  agent.send{|set| next_fibonacci(set)}
end
agent.await
puts agent.value
