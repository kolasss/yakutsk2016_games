# == Schema Information
#
# Table name: disciplines
#
#  id         :integer          not null, primary key
#  name       :jsonb            not null
#  finished   :boolean          default(FALSE), not null
#  sport_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase

  def setup
    @discipline = Discipline.new(
      name: {ru: 'Мужской', en: 'Man'},
      sport: sports(:tennis)
    )
  end

  test "should be valid" do
    assert @discipline.valid?
  end

  test "name should be present" do
    @discipline.name = nil
    assert_not @discipline.valid?
  end

  test "name should have right json content" do
    @discipline.name = "test"
    assert_not @discipline.valid?

    @discipline.name = {test: "123"}
    assert_not @discipline.valid?

    @discipline.name = {ru: "тест", en: "test"}
    assert @discipline.valid?
  end

  test "finished should be present" do
    @discipline.finished = nil
    assert_not @discipline.valid?
  end

  test "default finished should be false" do
    assert_equal false, @discipline.finished
  end

  test "sport should be present" do
    @discipline.sport = nil
    assert_not @discipline.valid?
  end

  test "can have teams" do
    discipline = disciplines(:beg)
    assert discipline.teams.any?
  end

  test 'should destroy teams with discipline' do
    discipline = disciplines(:beg)
    assert_difference('Team.count', -1) do
      discipline.destroy
    end
  end

  test "can have contests" do
    discipline = disciplines(:beg)
    assert discipline.contests.any?
  end

  test 'should destroy contests with discipline' do
    discipline = disciplines(:beg)
    assert_difference('Contest.count', -2) do
      discipline.destroy
    end
  end

  test "can have countries" do
    discipline = disciplines(:beg)
    assert discipline.countries.any?
  end

  test "can have athletes" do
    discipline = disciplines(:beg)
    assert discipline.athletes.any?
  end

  test "scope finished should exist" do
    finished = Discipline.where(finished: true)
    assert_equal finished, Discipline.finished
  end

  test "should update countries medals if finished value changed" do
    discipline = disciplines(:beg)
    country = discipline.countries.first
    assert_difference('Country.find(country.id).gold_count', 2) do
      discipline.finished = true
      discipline.save
    end
    assert_difference('Country.find(country.id).gold_count', -1) do
      discipline.finished = false
      discipline.save
    end
  end
end
