require 'concurrent'

p = Concurrent::Promise.new{10}
                    .then{|result| result * 2}
                    .then{|result| result - 5}

puts "#{p.state} #{p.fulfilled?} #{p.pending?}"

p.execute
puts "#{p.state} #{p.fulfilled?} #{p.pending?}"

sleep 1

puts "#{p.state} #{p.fulfilled?} #{p.pending?} #{p.value}"
