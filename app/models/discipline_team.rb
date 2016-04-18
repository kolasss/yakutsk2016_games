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
  belongs_to :team
  belongs_to :discipline

  has_many :participations, dependent: :destroy
  has_many :discipline_team_memberships, dependent: :destroy

  has_many :athletes, through: :discipline_team_memberships

  validates :team, presence: true
  validates :discipline, presence: true
  validates :rank,
            presence: true,
            numericality: {
              greater_than: 0
            }
end
