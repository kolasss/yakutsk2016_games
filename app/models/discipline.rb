# == Schema Information
#
# Table name: disciplines
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  finished   :boolean          default(FALSE), not null
#  sport_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  unit       :string
#

class Discipline < ActiveRecord::Base
  include JsonValidation

  belongs_to :sport

  has_many :teams, dependent: :destroy
  has_many :contests, dependent: :destroy

  has_many :countries, through: :teams
  has_many :athletes, through: :teams

  after_save :update_countries_medals

  validates :sport, presence: true
  validates :finished, inclusion: { in: [true, false] }
  validates :name,
            presence: true,
            json: JSON_VALIDATION

  scope :finished, -> { where(finished: true) }

  private

    def update_countries_medals
      self.countries.each(&:refresh_medals!) if finished_changed?
    end
end
