# == Schema Information
#
# Table name: bands
#
#  id          :integer          not null, primary key
#  name        :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Band < ApplicationRecord
	belongs_to :category
	has_many :cds
	has_many :band_members
	has_many :musicians, through: :band_members

	scope :younger_than, ->(year) { where('year > ?', year) }
	scope :oldest_than, ->(year) { where('year < ?', year) }
	scope :category, ->(category) { where(category: category) }

	scope :with_at_least_cds, ->(number) { all }
	scope :with_ex_members, -> { joins(:musicians).where('band_members.departure_at is not null') }

	scope :oldest, -> { order(year: :asc).limit(1) }

	scope :with_sales_record, -> { group(:name).joins(:cds).maximum(:sales) }

	scope :and_cds_by_category_and_release_cd_date, lambda { |category, cd_year_from, cd_year_to|  
		includes(:cds, :category).joins(:cds).category(category).merge(Cd.between(2000, 2010)) 
	}

	scope :with_average_cd_sales, ->(number) { group(:name).joins(:cds).average(:sales) }
	scope :with_total_cd_sales, ->(number) { group(:name).joins(:cds).count }

	# Load in ruby object than calculate, any? can also receive a block
	def self.any_with_more_than_x_copies_sold?(x)
		with_sales_record.any? { |band, sold_copies| sold_copies > x }
	end 

	# Calculates in query
	def self.exists_band_with_more_than_x_copies_sold?(x) 
		joins(:cds).where('cds.sales > ?', x).exists?
	end
end
