# == Schema Information
#
# Table name: team_memberships
#
#  id         :integer          not null, primary key
#  athlete_id :integer          not null
#  team_id    :integer          not null
#

require 'test_helper'

class TeamMembershipTest < ActiveSupport::TestCase

  def setup
    @team_membership = TeamMembership.new(
      athlete: athletes(:one),
      team: teams(:with_finished_discipline1)
    )
  end

  test "should be valid" do
    assert @team_membership.valid?
  end

  test "athlete should be present" do
    @team_membership.athlete = nil
    assert_not @team_membership.valid?
  end

  test "athlete should be uniq for team" do
    team_membership = team_memberships(:one)
    @team_membership.athlete = team_membership.athlete
    @team_membership.team = team_membership.team
    assert_not @team_membership.valid?
  end

  test "team should be present" do
    @team_membership.team = nil
    assert_not @team_membership.valid?
  end

  test "athlete's country and team's country should be the same" do
    @team_membership.athlete = athletes(:two)
    assert_not @team_membership.valid?
  end
end
