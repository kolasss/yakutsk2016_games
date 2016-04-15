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
end
