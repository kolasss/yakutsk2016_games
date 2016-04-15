# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  info       :text
#  team_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Athlete < ActiveRecord::Base
end
