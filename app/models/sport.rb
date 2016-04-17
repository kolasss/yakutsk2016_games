# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sport < ActiveRecord::Base
  has_many :disciplines, dependent: :destroy

  has_many :teams, through: :disciplines
  has_many :athletes, through: :disciplines

  mount_uploader :icon, FileUploader

  validates :name, presence: true
end
