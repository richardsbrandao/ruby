# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id            :integer          not null, primary key
#  name          :string
#  year          :integer
#  value         :integer
#  monthly_input :decimal(, )
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rent < Goal
end
