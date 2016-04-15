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
end
