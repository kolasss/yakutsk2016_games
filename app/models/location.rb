# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  address    :jsonb
#  info       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  include JsonValidation

  has_many :sports, dependent: :restrict_with_error
  has_many :events, dependent: :destroy

  validates :name,
            presence: true,
            json: JSON_VALIDATION
  validates :address,
            allow_blank: true,
            json: JSON_VALIDATION
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION
end
