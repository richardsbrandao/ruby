# == Schema Information
#
# Table name: musicians
#
#  id         :integer          not null, primary key
#  name       :string
#  born       :date
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Musician < ApplicationRecord
	has_many :band_members
	has_many :bands, through: :band_members
end
