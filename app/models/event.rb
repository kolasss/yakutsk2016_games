# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :datetime         not null
#  end_date    :datetime         not null
#  info        :jsonb
#  location_id :integer          not null
#  sport_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ActiveRecord::Base
  include JsonValidation

  belongs_to :sport
  belongs_to :location

  before_validation :set_location

  # validates :sport, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  # validates :info, presence: true
  validates :info,
            allow_blank: true,
            json: JSON_VALIDATION

  scope :actual_for, -> (date) { where('end_date >= ?', date) }

  private

    def set_location
      self.location = self.sport.location if self.sport.present?
    end
end
