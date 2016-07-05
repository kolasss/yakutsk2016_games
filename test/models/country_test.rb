# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  name         :jsonb            not null
#  flag         :string
#  info         :jsonb
#  gold_count   :integer          default(0), not null
#  silver_count :integer          default(0), not null
#  bronze_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cover        :string
#

require 'test_helper'

class CountryTest < ActiveSupport::TestCase

  def setup
    @country = Country.new(
      name: {ru: 'Япония', en: 'Japan'},
      info: {ru: 'Япония', en: 'Japan'},
      flag: Rack::Test::UploadedFile.new(
        File.join(ActionController::TestCase.fixture_path, '/files/mister.jpg'),
        'image/jpg'
      )
    )
  end

  test "should be valid" do
    assert @country.valid?
    assert File.exists?(@country.flag.path)
  end

  test "name should be present" do
    @country.name = nil
    assert_not @country.valid?
  end

  test "name should have right json content" do
    @country.name = "test"
    assert_not @country.valid?

    @country.name = {test: "123"}
    assert_not @country.valid?

    @country.name = {ru: "тест", en: "test"}
    assert @country.valid?
  end

  test "info should have right json content" do
    @country.info = {test: "123"}
    assert_not @country.valid?

    @country.info = nil
    assert @country.valid?

    @country.info = {ru: "тест", en: "test"}
    assert @country.valid?
  end

  test "can have athletes" do
    country = countries(:one)
    assert country.athletes.any?
  end

  test 'should destroy athletes with country' do
    country = countries(:one)
    assert_difference('Athlete.count', -1) do
      country.destroy
    end
  end

  test "can have teams" do
    country = countries(:one)
    assert country.teams.any?
  end

  test 'should destroy teams with country' do
    country = countries(:one)
    assert_difference('Team.count', -4) do
      country.destroy
    end
  end

  test "can have disciplines" do
    country = countries(:one)
    assert country.disciplines.any?
  end

  test "can have sports" do
    country = countries(:one)
    assert country.sports.any?
  end

  test "can have contests" do
    country = countries(:one)
    assert country.contests.any?
  end

  test "can have events" do
    country = countries(:one)
    assert country.events.any?
  end

  test "method refresh_medals! should update gold_count" do
    country = countries(:one)
    assert_difference('Country.find(country.id).gold_count', 1) do
      country.refresh_medals!
    end
  end

  test "method refresh_medals! should update silver_count" do
    country = countries(:one)
    assert_difference('Country.find(country.id).silver_count', 1) do
      country.refresh_medals!
    end
  end

  test "method refresh_medals! should update bronze_count" do
    country = countries(:one)
    assert_difference('Country.find(country.id).bronze_count', 1) do
      country.refresh_medals!
    end
  end
end
