# == Schema Information
#
# Table name: participations
#
#  id                 :integer          not null, primary key
#  score              :string
#  win                :boolean          default("false"), not null
#  discipline_team_id :integer          not null
#  event_id           :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Participation < ActiveRecord::Base
  belongs_to :discipline_team
  belongs_to :event

  validates :discipline_team, presence: true
  validates :event, presence: true
  validates :win, inclusion: { in: [true, false] }
end
