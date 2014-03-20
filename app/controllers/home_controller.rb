class HomeController < ApplicationController
  def index
    @rightimage = 'home'    
    @events = Event.upcoming
    @news_items = NewsItem.recent_three
    @staff_picks = StaffPick.three_staffs
    @re_sound = Airing.recent.first.feature if Airing.recent.first
   	@side_bar_tile_a = SideBarTiles.find_by_displayed(0)
   	@side_bar_tile_b = SideBarTiles.find_by_displayed(1)
    @side_bar_tile_c = SideBarTiles.find_by_displayed(2)
    @side_bar_tile_d = SideBarTiles.find_by_displayed(3)
  end

  def search
    @rightimage = "search"
    
    @results = ThinkingSphinx.search params[:q], :index_weights => { Page => 10 }, :per_page => 10, :page => params[:page]
  end
  
  def embed
    render :layout => false
  end

  def about
    render
  end

  def terms
    render
  end

end
