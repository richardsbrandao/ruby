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

	scope :with_average_cd_sales, ->(number) {  }
	scope :with_total_cd_sales, ->(number) {  }
end
