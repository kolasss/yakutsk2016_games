# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :date             not null
#  end_date    :date             not null
#  info        :text
#  location_id :integer          not null
#  sport_id    :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  belongs_to :sport
  belongs_to :location

  # validates :sport, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  # validates :info, presence: true
end
