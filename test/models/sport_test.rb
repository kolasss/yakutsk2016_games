# == Schema Information
#
# Table name: sports
#
#  id          :integer          not null, primary key
#  name        :jsonb            not null
#  icon        :string
#  photo_small :string
#  photo       :string
#  info        :jsonb
#  format      :integer          default(0), not null
#  location_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SportTest < ActiveSupport::TestCase

  def setup
    @sport = Sport.new(
      name: {ru: 'Бокс', en: 'Box'},
      location: locations(:one)
    )
  end

  test "should be valid" do
    assert @sport.valid?
  end

  test "name should be present" do
    @sport.name = nil
    assert_not @sport.valid?
  end
end
