require 'concurrent'

def next_fibonacci(set = nil)
  return [0, 1] if set.nil?
  set + [set[-2..-1].reduce{|sum,x| sum + x }]
end

def championship(set = nil)
	return [0] if set.nil?
	set + [[0,1,3].sample]
end

atom = Concurrent::Atom.new(championship)

38.times do
	atom.swap{|set| championship(set) }
end

puts "Pontuação Rodada a Rodada: #{atom.value}"
puts "Total: #{atom.value.sum}"
