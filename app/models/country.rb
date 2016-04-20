# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  flag       :string
#  info       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ActiveRecord::Base
  has_many :athletes, dependent: :destroy
  has_many :teams, dependent: :destroy

  # has_many :disciplines, through: :teams
  # has_many :sports, through: :disciplines

  mount_uploader :flag, FileUploader

  validates :name, presence: true
end
