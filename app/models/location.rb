# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :jsonb            default("{}"), not null
#  address    :jsonb            default("{}")
#  info       :jsonb            default("{}")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  include JsonValidation

  has_many :contests, dependent: :destroy
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
