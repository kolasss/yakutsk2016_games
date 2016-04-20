# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  photo      :string
#  info       :text
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Athlete < ActiveRecord::Base
  belongs_to :country

  has_many :team_memberships, dependent: :destroy

  has_many :teams, through: :team_memberships
  # has_many :disciplines, through: :teams
  # has_many :sports, through: :disciplines

  validates :name, presence: true
  validates :country, presence: true
end
