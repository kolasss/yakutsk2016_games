# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ActiveRecord::Base
  belongs_to :country

  has_many :athletes, dependent: :destroy
  has_many :discipline_teams, dependent: :destroy

  has_many :disciplines, through: :discipline_teams
  has_many :sports, through: :disciplines

  validates :country, presence: true
end
