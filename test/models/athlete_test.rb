# == Schema Information
#
# Table name: athletes
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  photo      :string
#  info       :jsonb
#  country_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AthleteTest < ActiveSupport::TestCase

  def setup
    @athlete = Athlete.new(
      name: {ru: 'Япония', en: 'Japan'},
      info: {ru: 'Япония', en: 'Japan'},
      photo: Rack::Test::UploadedFile.new(
        File.join(ActionController::TestCase.fixture_path, '/files/mister.jpg'),
        'image/jpg'
      ),
      country: countries(:one)
    )
  end

  test "should be valid" do
    assert @athlete.valid?
    assert File.exists?(@athlete.photo.path)
  end

  test "name should be present" do
    @athlete.name = nil
    assert_not @athlete.valid?
  end

  test "name should have right json content" do
    @athlete.name = "test"
    assert_not @athlete.valid?

    @athlete.name = {test: "123"}
    assert_not @athlete.valid?

    @athlete.name = {ru: "тест", en: "test"}
    assert @athlete.valid?
  end

  test "info should have right json content" do
    @athlete.info = {test: "123"}
    assert_not @athlete.valid?

    @athlete.info = nil
    assert @athlete.valid?

    @athlete.info = {ru: "тест", en: "test"}
    assert @athlete.valid?
  end

  test "country should be present" do
    @athlete.country = nil
    assert_not @athlete.valid?
  end

  test "can have team_memberships" do
    athlete = athletes(:one)
    assert athlete.team_memberships.any?
  end

  test 'should destroy team_memberships with athlete' do
    athlete = athletes(:one)
    assert_difference('TeamMembership.count', -1) do
      athlete.destroy
    end
  end

  test "can have teams" do
    athlete = athletes(:one)
    assert athlete.teams.any?
  end

  test "can have participations" do
    athlete = athletes(:one)
    assert athlete.participations.any?
  end

  test "can have contests" do
    athlete = athletes(:one)
    assert athlete.contests.any?
  end

  test "can have disciplines" do
    athlete = athletes(:one)
    assert athlete.disciplines.any?
  end
end
