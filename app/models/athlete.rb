# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  info       :text
#  team_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Athlete < ActiveRecord::Base
  belongs_to :team

  has_and_belongs_to_many :discipline_teams

  has_many :disciplines, through: :discipline_teams
  has_many :sports, through: :disciplines

  validates :name, presence: true
  validates :team, presence: true
end
