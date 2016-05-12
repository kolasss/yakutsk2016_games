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
      location: locations(:one),
      photo: Rack::Test::UploadedFile.new(
        File.join(ActionController::TestCase.fixture_path, '/files/mister.jpg'),
        'image/jpg'
      )
    )
  end

  test "should be valid" do
    assert @sport.valid?
    assert File.exists?(@sport.photo.path)
  end

  test "name should be present" do
    @sport.name = nil
    assert_not @sport.valid?
  end

  test "name should have right json content" do
    @sport.name = "test"
    assert_not @sport.valid?

    @sport.name = {test: "123"}
    assert_not @sport.valid?

    @sport.name = {ru: "тест", en: "test"}
    assert @sport.valid?
  end

  test "location should be present" do
    @sport.location = nil
    assert_not @sport.valid?
  end

  test "format should be present" do
    @sport.format = nil
    assert_not @sport.valid?
  end

  test "default format should be grid" do
    assert_equal "grid", @sport.format
  end

  test "info should have right json content" do
    @sport.info = {test: "123"}
    assert_not @sport.valid?

    @sport.info = nil
    assert @sport.valid?

    @sport.info = {ru: "тест", en: "test"}
    assert @sport.valid?
  end

  test "can have disciplines" do
    sport = sports(:legkaya)
    assert sport.disciplines.any?
  end

  test 'should destroy disciplines with sport' do
    sport = sports(:legkaya)
    assert_difference('Discipline.count', -3) do
      sport.destroy
    end
  end

  test "can have events" do
    sport = sports(:legkaya)
    assert sport.events.any?
  end

  test 'should destroy events with sport' do
    sport = sports(:legkaya)
    assert_difference('Event.count', -2) do
      sport.destroy
    end
  end

  test "can have teams" do
    sport = sports(:legkaya)
    assert sport.teams.any?
  end

  test "can have countries" do
    sport = sports(:legkaya)
    assert sport.countries.any?
  end

  test "can have contests" do
    sport = sports(:legkaya)
    assert sport.contests.any?
  end

  test "can have icon" do
    sport = sports(:legkaya)
    # file path: test/fixtures/files/uploads/sport/icon/53186114/photo1.jpg
    assert File.exists?(sport.icon.file.path)
  end

  test "can have photo" do
    sport = sports(:legkaya)
    # file path: test/fixtures/files/uploads/sport/photo/53186114/photo2.jpg
    assert File.exists?(sport.photo.file.path)
  end

  test "can have photo_small" do
    sport = sports(:legkaya)
    # file path: test/fixtures/files/uploads/sport/photo_small/53186114/photo3.jpg
    assert File.exists?(sport.photo_small.file.path)
  end
end
