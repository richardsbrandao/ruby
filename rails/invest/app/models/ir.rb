# == Schema Information
#
# Table name: irs
#
#  id         :integer          not null, primary key
#  tax        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ir < ApplicationRecord
end
