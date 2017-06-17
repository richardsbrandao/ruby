# == Schema Information
#
# Table name: investiments
#
#  id         :integer          not null, primary key
#  name       :string
#  model      :string
#  ir_id      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Investiment < ApplicationRecord
  belongs_to :ir
end
