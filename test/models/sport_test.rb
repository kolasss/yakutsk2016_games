# == Schema Information
#
# Table name: sports
#
#  id          :integer          not null, primary key
#  name        :jsonb            not null
#  icon        :string
#  info        :jsonb
#  format      :integer          default(0), not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
