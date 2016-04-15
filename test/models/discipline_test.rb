# == Schema Information
#
# Table name: disciplines
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  finished   :boolean          default("false"), not null
#  sport_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
