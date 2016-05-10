# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  info       :jsonb
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
