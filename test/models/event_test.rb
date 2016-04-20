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

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
