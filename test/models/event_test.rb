# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  start_date  :datetime         not null
#  end_date    :datetime         not null
#  info        :jsonb
#  location_id :integer          not null
#  sport_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @event = Event.new(
      start_date: Time.current + 1.day,
      end_date: Time.current + 5.days,
      sport: sports(:tennis)
    )
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "start_date should be present" do
    @event.start_date = nil
    assert_not @event.valid?
  end

  test "end_date should be present" do
    @event.end_date = nil
    assert_not @event.valid?
  end

  test "location should be present" do
    @event.sport = nil
    @event.location = nil
    assert_not @event.valid?
  end

  test "location should be equal to sport's location if sport is present" do
    assert @event.sport
    assert @event.valid?
    assert_equal @event.location, @event.sport.location
  end

  test "info should have right json content" do
    @event.info = {test: "123"}
    assert_not @event.valid?

    @event.info = nil
    assert @event.valid?

    @event.info = {ru: "тест", en: "test"}
    assert @event.valid?
  end

  test "scope actual_for date should exist" do
    date = Date.parse '2016-04-21'
    actual = Event.where('end_date >= ?', date)
    assert_equal actual, Event.actual_for(date)
    assert_equal 2, Event.actual_for(date).count
  end
end
