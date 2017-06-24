# frozen_string_literal: true

# == Schema Information
#
# Table name: goals
#
#  id                     :integer          not null, primary key
#  name                   :string
#  year                   :integer
#  type                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  amount_cents           :integer          default(0), not null
#  amount_currency        :string           default("BRL"), not null
#  monthly_input_cents    :integer          default(0), not null
#  monthly_input_currency :string           default("BRL"), not null
#

class Rent < Goal
end
