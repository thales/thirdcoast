module EventsHelper
  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end

  def days_in_prev_month(date = @date)
    date = date - 1.month
    days_in_month(date.year, date.month)
  end

  def month_offset(year, month)
    Date.new(year, month, 1).wday
  end

  def month_left(year, month)
    6 - Date.new(year, month, days_in_month(year,month) ).wday
  end
  
  def day_events_css(year, month, day, events)
    date = Date.new year, month, day
    events = events.find {|obj| obj.e_date == date }
    
    if events.nil?
      ""
    elsif events.flavor == "regular"
      "calendar_block_day_has_events"
    elsif events.flavor == "deadline"
      "calendar_block_day_has_deadlines"
    end
  end

  def other_month_url(dir, date = @date)
    if dir == :next
      date += 1.month
    elsif dir == :prev
      date -= 1.month
    end

    events_month_url :year => date.year, :month => date.month
  end
end
