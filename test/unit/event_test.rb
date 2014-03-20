require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should_have_db_column :name
  should_have_db_column :short_description
  should_have_db_column :host
  should_have_db_column :location
  should_have_db_column :e_date
  should_have_db_column :is_3rdcoastevent

  should_validate_presence_of :name
  
  test "upcoming" do
    event1 = Factory.create :event, :e_date => 1.week.ago
    event2 = Factory.create :event, :e_date => 1.week.from_now
    event3 = Factory.create :event, :e_date => 2.days.from_now
    event4 = Factory.create :event, :e_date => 2.months.from_now
    
    assert !Event.upcoming.find_by_id(event1.id)
    assert !Event.upcoming.include?(event1)
    assert_equal event2, Event.upcoming[1]
    assert_equal event3, Event.upcoming[0]
    
    assert_equal 2, Event.upcoming.length
    
  end
  
  test "deadline?" do
    event1 = Factory.create :event, :flavor => "regular"
    event2 = Factory.create :event, :flavor => "deadline"
    
    assert !event1.deadline?
    assert event2.deadline?
  end
end
