module HomeHelper
  def result_title(s)
    case s.class.to_s
      when "Event"
        link_to(s.name, event_url(s))
      when "NewsItem"
        s.title
      when "Feature"
        link_to s.title, player_url(s.id), :rel => 'playerPopup'
      when "Page"
        link_to s.title, "/#{s.slug}"
      when "Donor"
        s.name
      when "StaffPick"
        s.name
    end
  end
  
  def result_content(s)
    case s.class.to_s
      when "Event"
        s.short_description
      when "NewsItem"
        s.description
      when "Feature"
        truncate_feature_description(s)
    end
  end
end
