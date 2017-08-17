class Indexer < ActiveRecord::Base
  has_many :variations

  validates :name, presence: true

  def belongs_to(variation)
    variations.each do |saved_variation|
      return true if saved_variation == variation
    end

    false
  end
end
