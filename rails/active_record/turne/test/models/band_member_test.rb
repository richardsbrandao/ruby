# == Schema Information
#
# Table name: band_members
#
#  id           :integer          not null, primary key
#  band_id      :integer
#  musician_id  :integer
#  role         :string
#  arrival_at   :date
#  departure_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class BandMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
