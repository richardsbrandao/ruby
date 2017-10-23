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

require 'test_helper'

class MusicianTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
