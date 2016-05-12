# == Schema Information
#
# Table name: teams
#
#  id            :integer          not null, primary key
#  name          :jsonb
#  rank          :integer
#  discipline_id :integer          not null
#  country_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  def setup
    @team = Team.new(
      name: {ru: 'Япония', en: 'Japan'},
      country: countries(:one),
      discipline: disciplines(:prijki)
    )
  end

  test "should be valid" do
    assert @team.valid?
  end

  test "country should be present" do
    @team.country = nil
    assert_not @team.valid?
  end

  test "discipline should be present" do
    @team.discipline = nil
    assert_not @team.valid?
  end

  test "rank should be integer" do
    @team.rank = 'one'
    assert_not @team.valid?
  end

  test "rank should be greater than 0" do
    @team.rank = -1
    assert_not @team.valid?

    @team.rank = 0
    assert_not @team.valid?

    @team.rank = 9
    assert @team.valid?
  end

  test "name should have right json content" do
    @team.name = {test: "123"}
    assert_not @team.valid?

    @team.name = nil
    assert @team.valid?

    @team.name = {ru: "тест", en: "test"}
    assert @team.valid?
  end

  test "can have team_memberships" do
    team = teams(:one)
    assert team.team_memberships.any?
  end

  test 'should destroy team_memberships with team' do
    team = teams(:one)
    assert_difference('TeamMembership.count', -1) do
      team.destroy
    end
  end

  test "can have participations" do
    team = teams(:one)
    assert team.participations.any?
  end

  test 'should destroy participations with team' do
    team = teams(:one)
    assert_difference('Participation.count', -1) do
      team.destroy
    end
  end

  test "can have athletes" do
    team = teams(:one)
    assert team.athletes.any?
  end

  test "can have contests" do
    team = teams(:one)
    assert team.contests.any?
  end

  test "should accept nested attributes for team_memberships" do
    assert_difference 'TeamMembership.count' do
      @team.assign_attributes(
        team_memberships_attributes: [{
          athlete_id: athletes(:one).id
        }]
      )
      @team.save
    end
    assert @team.reload.team_memberships.present?
  end

  test "should destroy team_memberships through accept nested attributes" do
    team = teams(:one)
    assert_difference 'TeamMembership.count', -1 do
      team.update(
        team_memberships_attributes: [{
          id: team.team_memberships.first.id,
          _destroy: true
        }]
      )
    end
  end
end
