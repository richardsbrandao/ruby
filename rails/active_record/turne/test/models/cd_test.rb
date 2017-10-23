# == Schema Information
#
# Table name: cds
#
#  id         :integer          not null, primary key
#  year       :integer
#  title      :string
#  salles     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer
#

require 'test_helper'

class CdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
