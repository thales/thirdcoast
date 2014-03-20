class PagesController < ApplicationController
  before_filter :require_user, :only => [:preview]
  
  def show
    slugs = params[:path]

    @top_page = Page.find_by_slug slugs[0]
    
    @page = Page.first :conditions => {:slug => slugs.pop, :slug_prefix => slugs.join('/')  }
    
    raise  ActiveRecord::RecordNotFound unless @page && @page.published?
    
    @rightimage = @top_page.slug
   	@side_bar_tile_a = SideBarTiles.find_by_displayed(0)
   	@side_bar_tile_b = SideBarTiles.find_by_displayed(1)
    @side_bar_tile_c = SideBarTiles.find_by_displayed(2)
    @side_bar_tile_d = SideBarTiles.find_by_displayed(3)
  end
  
  def preview
    @page = Page.find params[:id]
    parts = params["page"]["parts_attributes"]
    doc = Nokogiri::HTML(@page.template.content )
    doc.css("div[rel=section]").each do |section|
      content = parts.find do |key, part|
        (PagePart.find(part["id"]).name.to_s == section.attribute('section-title').to_s)
      end
      section.inner_html = content[1]["content"]
    end
    
    html_matched = doc.to_s.match(/<body>((.)*)<\/body>/m)
    
    if html_matched
      @body = html_matched[1]
    else
      @body = doc.to_s
    end
    
   	@side_bar_tile_a = SideBarTiles.find_by_displayed(0)
   	@side_bar_tile_b = SideBarTiles.find_by_displayed(1)
    @side_bar_tile_c = SideBarTiles.find_by_displayed(2)
    @side_bar_tile_d = SideBarTiles.find_by_displayed(3)

    render :action => "show"
  end
end
