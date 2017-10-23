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

require 'test_helper'

class BandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
