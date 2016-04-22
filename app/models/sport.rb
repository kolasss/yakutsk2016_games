# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :jsonb            default("{}"), not null
#  icon       :string
#  info       :jsonb            default("{}")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sport < ActiveRecord::Base
  include JsonValidation

  belongs_to :location

  has_many :disciplines, dependent: :destroy
  has_many :events, dependent: :destroy

  has_many :teams, through: :disciplines
  has_many :countries, -> { distinct }, through: :teams
  has_many :contests, through: :disciplines
  # has_many :athletes, through: :disciplines

  mount_uploader :icon, FileUploader

  validates :location, presence: true
  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION
end
