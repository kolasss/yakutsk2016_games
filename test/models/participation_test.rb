# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  score      :string
#  rank       :integer
#  team_id    :integer          not null
#  contest_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase

  def setup
    @participation = Participation.new(
      score: '1 m',
      rank: 3,
      team: teams(:one),
      contest: contests(:two)
    )
  end

  test "should be valid" do
    assert @participation.valid?
  end

  test "team should be present" do
    @participation.team = nil
    assert_not @participation.valid?
  end

  test "contest should be present" do
    @participation.contest = nil
    assert_not @participation.valid?
  end

  test "contest should be uniq for team" do
    participation = participations(:one)
    @participation.contest = participation.contest
    @participation.team = participation.team
    assert_not @participation.valid?
  end

  test "rank should be integer" do
    @participation.rank = 'one'
    assert_not @participation.valid?
  end

  test "rank should be greater than 0" do
    @participation.rank = -1
    assert_not @participation.valid?

    @participation.rank = 0
    assert_not @participation.valid?

    @participation.rank = 9
    assert @participation.valid?
  end

  test "contest's discipline and team's discipline should be the same" do
    @participation.contest = contests(:tree1)
    assert_not @participation.valid?
  end
end
