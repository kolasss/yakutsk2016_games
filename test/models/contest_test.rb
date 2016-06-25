# == Schema Information
#
# Table name: contests
#
#  id            :integer          not null, primary key
#  name          :jsonb
#  start_at      :datetime
#  published_at  :datetime
#  parent_id     :integer
#  sort_order    :integer
#  discipline_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  in_group      :boolean          default(FALSE)
#  group_id      :integer
#

require 'test_helper'

class ContestTest < ActiveSupport::TestCase

  def setup
    @contest = Contest.new(
      name: {ru: 'Финал', en: 'Final'},
      start_at: Time.current + 1.day,
      discipline: disciplines(:prijki)
    )
  end

  test "should be valid" do
    assert @contest.valid?
  end

  test "discipline should be present" do
    @contest.discipline = nil
    assert_not @contest.valid?
  end

  test "name should have right json content" do
    @contest.name = {test: "123"}
    assert_not @contest.valid?

    @contest.name = nil
    assert @contest.valid?

    @contest.name = {ru: "тест", en: "test"}
    assert @contest.valid?
  end

  test "can have participations" do
    contest = contests(:one)
    assert contest.participations.any?
  end

  test 'should destroy participations with contest' do
    contest = contests(:one)
    assert_difference('Participation.count', -1) do
      contest.destroy
    end
  end

  test "should accept nested attributes for participations" do
    assert_difference 'Participation.count' do
      @contest.assign_attributes(
        participations_attributes: [{
          team_id: teams(:two).id
        }]
      )
      @contest.save
    end
    assert @contest.reload.participations.present?
  end

  test "should destroy participations through accept nested attributes" do
    contest = contests(:one)
    assert_difference 'Participation.count', -1 do
      contest.update(
        participations_attributes: [{
          id: contest.participations.first.id,
          _destroy: true
        }]
      )
    end
  end

  test "scope published should exist" do
    published = Contest.where.not(published_at: nil).order(published_at: :desc)
    assert_equal published, Contest.published
  end

  test "method published?" do
    assert_not @contest.published?

    contest = contests(:one)
    assert contest.published?
  end

  test "contests should have method hash_tree" do
    Contest.rebuild!
    discipline = disciplines(:prijki)
    assert discipline.contests.hash_tree.is_a? Hash
  end

  test "can set child with method append_child" do
    contest = contests(:tree3)
    assert_not @contest.parent.present?
    contest.append_child @contest
    assert @contest.valid?
    assert_equal contest, @contest.reload.parent
  end

  test "parent contest should have same discipline" do
    contest = contests(:one)
    contest.append_child @contest
    assert_not @contest.valid?
  end
end
