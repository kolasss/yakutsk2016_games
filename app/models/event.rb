# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  name           :string
#  start_at       :datetime
#  published_at   :datetime
#  path           :string
#  depth          :integer
#  position       :integer
#  parent_id      :integer
#  children_count :integer
#  location_id    :integer          not null
#  discipline_id  :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Event < ActiveRecord::Base
  has_hierarchy
end
