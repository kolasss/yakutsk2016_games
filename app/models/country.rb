# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  flag       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ActiveRecord::Base
  has_many :teams, dependent: :destroy

  mount_uploader :flag, FileUploader

  validates :name, presence: true
end
