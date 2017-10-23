# == Schema Information
#
# Table name: cds
#
#  id         :integer          not null, primary key
#  year       :integer
#  title      :string
#  sales     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer
#

class Cd < ApplicationRecord
	belongs_to :band

	scope :average_sales_by_band, -> { group(:band_id).average(:sales) }
	scope :sum_sales_by_band, -> { group(:band_id).sum(:sales) }
	scope :max_sales, -> { maximum(:sales) }
	scope :min_sales, -> { minimum(:sales) }
end
