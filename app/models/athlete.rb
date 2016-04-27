# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  photo      :string
#  info       :jsonb
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Athlete < ActiveRecord::Base
  include JsonValidation

  belongs_to :country

  has_many :team_memberships, dependent: :destroy

  has_many :teams,          through: :team_memberships
  has_many :participations, through: :teams
  has_many :contests,       through: :participations
  has_many :disciplines, through: :teams
  # has_many :sports, through: :disciplines

  mount_uploader :photo, FileUploader

  validates :country, presence: true
  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION
end
