# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  score      :string
#  rank       :integer
#  team_id    :integer          not null
#  contest_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
