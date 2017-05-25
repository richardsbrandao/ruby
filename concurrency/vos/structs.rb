require 'concurrent'

# ImmutableStruct Immutable struct where values are set at construction and cannot be changed later.
# MutableStruct Synchronized, mutable struct where values can be safely changed at any time.
# SettableStruct Synchronized, write-once struct where values can be set at most once, either at construction or any time thereafter.

StructPair = Struct.new(:left, :right)
SafePair = Concurrent::MutableStruct.new(:left, :right)
FinalPair = Concurrent::SettableStruct.new(:left, :right)
ImmutablePair = Concurrent::ImmutableStruct.new(:left, :right)

array_pair = [true, false].freeze
struct_pair = StructPair.new(true, false)
safe_pair = SafePair.new(true, false)
final_pair = FinalPair.new(true, false)
immutable = ImmutablePair.new(true, false)

puts array_pair
puts struct_pair
puts safe_pair
puts final_pair
puts immutable