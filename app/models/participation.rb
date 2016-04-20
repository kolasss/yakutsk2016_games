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

class Participation < ActiveRecord::Base
  belongs_to :team
  belongs_to :contest

  validates :team, presence: true
  validates :contest,
            presence: true,
            uniqueness: { scope: :team }
  validates :rank,
            numericality: {
              greater_than: 0
            },
            allow_nil: true
end
