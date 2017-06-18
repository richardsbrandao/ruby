# frozen_string_literal: true

# == Schema Information
#
# Table name: index_values
#
#  id         :integer          not null, primary key
#  period     :string
#  value      :decimal(, )
#  index_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IndexValue < ApplicationRecord
  belongs_to :index
end
