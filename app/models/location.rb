# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  address    :text
#  info       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ActiveRecord::Base
  has_many :contests, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true
end
