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
  has_and_belongs_to_many :athletes

  validates :team, presence: true
  validates :discipline, presence: true
  validates :rank,
            presence: true,
            numericality: {
              greater_than: 0
            }
end
