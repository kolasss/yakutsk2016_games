# == Schema Information
#
# Table name: team_memberships
#
#  id         :integer          not null, primary key
#  athlete_id :integer          not null
#  team_id    :integer          not null
#

class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :athlete

  validates :team, presence: true
  validates :athlete,
            presence: true,
            uniqueness: { scope: :team }

  validate :athlete_and_team_countries_equals

  private

    def athlete_and_team_countries_equals
      if self.team && self.athlete && self.team.country != self.athlete.country
        errors.add(:athlete_id, "страна не соотвествует")
      end
    end
end
