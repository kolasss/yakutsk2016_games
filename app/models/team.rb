# == Schema Information
#
# Table name: teams
#
#  id            :integer          not null, primary key
#  name          :jsonb
#  rank          :integer
#  discipline_id :integer          not null
#  country_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Team < ActiveRecord::Base
  include JsonValidation

  belongs_to :country
  belongs_to :discipline

  has_many :participations, dependent: :destroy
  has_many :team_memberships,
    dependent: :destroy,
    inverse_of: :team

  has_many :athletes, through: :team_memberships
  has_many :contests, through: :participations

  accepts_nested_attributes_for :team_memberships, allow_destroy: true

  # before_validation :set_name

  validates :country, presence: true
  validates :discipline, presence: true
  validates :rank,
            numericality: {
              greater_than: 0
            },
            allow_nil: true
  validates :name,
            allow_blank: true,
            json: JSON_VALIDATION

  # private

  #   def set_name
  #     self.name ||= self.athletes.first.name if self.athletes.count == 1
  #   end
end
