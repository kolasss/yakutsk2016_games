# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :jsonb            default("{}"), not null
#  photo      :string
#  info       :jsonb            default("{}")
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AthleteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
