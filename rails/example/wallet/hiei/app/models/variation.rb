class Variation < ActiveRecord::Base
  belongs_to :indexer

  validates :year, presence: true, numericality: { only_integer: true }
  validates :month, presence: true, numericality: { only_integer: true }
  validates :percent, presence: true, numericality: true
  validates_inclusion_of :month, in: 1..12
end
