# frozen_string_literal: true

# == Schema Information
#
# Table name: investiments
#
#  id         :integer          not null, primary key
#  name       :string
#  model      :string
#  year_yield :decimal(8, 2)
#  ir_id      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Investiment < ApplicationRecord
  belongs_to :ir
end
