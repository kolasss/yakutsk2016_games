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

class DisciplineTeam < ActiveRecord::Base
end
