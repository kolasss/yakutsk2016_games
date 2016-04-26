# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :jsonb            not null
#  flag         :string
#  info         :jsonb
#  gold_count   :integer          default(0), not null
#  silver_count :integer          default(0), not null
#  bronze_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Country < ActiveRecord::Base
  include JsonValidation

  has_many :athletes, dependent: :destroy
  has_many :teams, dependent: :destroy

  has_many :disciplines, -> { distinct }, through: :teams
  has_many :sports, -> { distinct }, through: :disciplines
  has_many :contests, -> { distinct }, through: :teams
  has_many :events, -> { distinct }, through: :sports

  mount_uploader :flag, FileUploader

  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION

  def refresh_medals!
    self.gold_count = self.teams.joins(:discipline).merge(Discipline.finished).where(rank: 1).count
    self.silver_count = self.teams.joins(:discipline).merge(Discipline.finished).where(rank: 2).count
    self.bronze_count = self.teams.joins(:discipline).merge(Discipline.finished).where(rank: 3).count
    save!
  end
end
