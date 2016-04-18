# == Schema Information
#
# Table name: discipline_team_memberships
#
#  id                 :integer          not null, primary key
#  athlete_id         :integer          not null
#  discipline_team_id :integer          not null
#

class DisciplineTeamMembership < ActiveRecord::Base
  belongs_to :discipline_team
  belongs_to :athlete

  validates :discipline_team, presence: true
  validates :athlete,
            presence: true,
            uniqueness: { scope: :discipline_team }

  validate :athlete_and_dteam_teams_equals

  private

    def athlete_and_dteam_teams_equals
      if self.discipline_team.team != self.athlete.team
        errors.add(:athlete_id, "команда не соотвествует")
      end
    end
end
