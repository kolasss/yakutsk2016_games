# == Schema Information
#
# Table name: teams
#
#  id            :integer          not null, primary key
#  rank          :integer
#  discipline_id :integer          not null
#  country_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Team < ActiveRecord::Base
  belongs_to :country
  belongs_to :discipline

  has_many :participations, dependent: :destroy
  has_many :team_memberships, dependent: :destroy

  has_many :athletes, through: :team_memberships

  validates :country, presence: true
  validates :discipline, presence: true
  validates :rank,
            numericality: {
              greater_than: 0
            },
            allow_nil: true
end
