# == Schema Information
#
# Table name: sports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  icon       :string
#  info       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class SportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
