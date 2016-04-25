# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  flag       :string
#  info       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ActiveRecord::Base
  include JsonValidation

  has_many :athletes, dependent: :destroy
  has_many :teams, dependent: :destroy

  # has_many :disciplines, through: :teams
  # has_many :sports, through: :disciplines

  mount_uploader :flag, FileUploader

  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION
end
