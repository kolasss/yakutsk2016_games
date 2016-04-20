# == Schema Information
#
# Table name: contests
#
#  id            :integer          not null, primary key
#  name          :string
#  start_at      :datetime
#  published_at  :datetime
#  parent_id     :integer
#  sort_order    :integer
#  location_id   :integer          not null
#  discipline_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ContestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
