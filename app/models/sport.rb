# == Schema Information
#
# Table name: sports
#
#  id          :integer          not null, primary key
#  name        :jsonb            not null
#  icon        :string
#  photo_small :string
#  photo       :string
#  info        :jsonb
#  format      :integer          default(0), not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sport < ActiveRecord::Base
  include JsonValidation

  belongs_to :location

  has_many :disciplines, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :attachments,
    dependent: :destroy,
    inverse_of: :sport

  has_many :teams, through: :disciplines
  has_many :countries, -> { distinct }, through: :teams
  has_many :contests, through: :disciplines
  # has_many :athletes, through: :disciplines

  accepts_nested_attributes_for :attachments, allow_destroy: true

  mount_uploader :icon, ImageUploader
  mount_uploader :photo, ImageUploader
  mount_uploader :photo_small, ImageUploader

  enum format: {
    grid: 0,
    circular: 10,
    simple: 20,
    football: 30
  }

  validates :location, presence: true
  validates :format, presence: true
  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION
end
