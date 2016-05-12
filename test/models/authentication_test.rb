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

  def setup
    @authentication = Authentication.new(
      info: {perviy: 'ллалала', vtoroy: 1234},
      user: users(:one)
    )
  end

  test "should be valid" do
    assert @authentication.valid?
  end

  test "user should be present" do
    @authentication.user = nil
    assert_not @authentication.valid?
  end
end
