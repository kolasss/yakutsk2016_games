# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  address    :jsonb
#  info       :jsonb
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  for_sport  :boolean          default(FALSE), not null
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  def setup
    @location = Location.new(
      name: {ru: 'Стадион', en: 'Stadium'},
      address: {ru: 'Стадион', en: 'Stadium'},
      info: {ru: 'Стадион', en: 'Stadium'},
      photo: Rack::Test::UploadedFile.new(
        File.join(ActionController::TestCase.fixture_path, '/files/mister.jpg'),
        'image/jpg'
      )
    )
  end

  test "should be valid" do
    assert @location.valid?
    assert File.exists?(@location.photo.path)
  end

  test "name should be present" do
    @location.name = nil
    assert_not @location.valid?
  end

  test "name should have right json content" do
    @location.name = "test"
    assert_not @location.valid?

    @location.name = {test: "123"}
    assert_not @location.valid?

    @location.name = {ru: "тест", en: "test"}
    assert @location.valid?
  end

  test "address should have right json content" do
    @location.address = {test: "123"}
    assert_not @location.valid?

    @location.address = nil
    assert @location.valid?

    @location.address = {ru: "тест", en: "test"}
    assert @location.valid?
  end

  test "info should have right json content" do
    @location.info = {test: "123"}
    assert_not @location.valid?

    @location.info = nil
    assert @location.valid?

    @location.info = {ru: "тест", en: "test"}
    assert @location.valid?
  end

  test "can have events" do
    location = locations(:one)
    assert location.events.any?
  end

  test 'should destroy events with location' do
    location = locations(:wo_sport)
    assert_difference('Event.count', -1) do
      location.destroy
    end
  end

  test "can have sports" do
    location = locations(:one)
    assert location.sports.any?
  end

  test "should not allow destroy with exist sport" do
    @location.save
    sport = sports(:legkaya)
    sport.location = @location
    sport.save
    assert_not @location.destroy
  end
end
