# == Schema Information
#
# Table name: disciplines
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  finished   :boolean          default("false"), not null
#  sport_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Discipline < ActiveRecord::Base
  belongs_to :sport

  has_many :teams, dependent: :destroy
  has_many :contests, dependent: :destroy

  # has_many :teams, through: :teams
  # has_many :athletes, through: :teams

  validates :name, presence: true
  validates :sport, presence: true
  validates :finished, inclusion: { in: [true, false] }
end
