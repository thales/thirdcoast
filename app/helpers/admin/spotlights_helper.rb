module Admin::SpotlightsHelper
  def sort_link
    if params[:order] == "az"
      link_to "Spotlight date", admin_spotlights_url(:order => "date", :page => 1)
    else
      link_to "A-Z", admin_spotlights_url(:order => "az", :page => 1)      
    end
    
  end
end
