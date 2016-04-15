# == Schema Information
#
# Table name: discipline_teams
#
#  id            :integer          not null, primary key
#  rank          :integer          default("9999"), not null
#  discipline_id :integer          not null
#  team_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class DisciplineTeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
