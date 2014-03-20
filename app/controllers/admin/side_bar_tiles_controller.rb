class Admin::SideBarTilesController < Admin::ApplicationController
  layout 'admin'

  def index
    @side_bar_tiles = SideBarTiles.ordered.paginate :page => params[:page], :per_page => 20
  end

  def new
    @side_bar_tile = SideBarTiles.new
  end

  def create
    @side_bar_tile = SideBarTiles.new params[:side_bar_tiles]

    if @side_bar_tile.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def edit
    @side_bar_tile = SideBarTiles.find params[:id]
  end

  def update
  	if params[:side_bar_tiles][:display_a].nil? && params[:side_bar_tiles][:display_b].nil? && params[:side_bar_tiles][:display_c].nil? && params[:side_bar_tiles][:display_d].nil?
			@side_bar_tile = SideBarTiles.find params[:id]
	
			@side_bar_tile.update_attributes params[:side_bar_tiles]
		else 
			SideBarTiles.update_all("displayed = NULL")

			@side_bar_tile_display_a = SideBarTiles.find_by_id(params[:side_bar_tiles][:display_a])
			@side_bar_tile_display_b = SideBarTiles.find_by_id(params[:side_bar_tiles][:display_b])
			@side_bar_tile_display_a.update_attribute("displayed", "0")
			@side_bar_tile_display_b.update_attribute("displayed", "1")


      if params[:side_bar_tiles][:display_c] != 'none'
        @side_bar_tile_display_c = SideBarTiles.find_by_id(params[:side_bar_tiles][:display_c])
        @side_bar_tile_display_c.update_attribute("displayed", "2")
      end


      if params[:side_bar_tiles][:display_d] != 'none'
        @side_bar_tile_display_d = SideBarTiles.find_by_id(params[:side_bar_tiles][:display_d])
        @side_bar_tile_display_d.update_attribute("displayed", "3")
      end

			flash[:notice] = "Selected homepage tiles saved."

		end
		redirect_to :action => "index"
  end

  def destroy
    @side_bar_tile = SideBarTiles.find params[:id]

    @side_bar_tile.deleted = true
    @side_bar_tile.save!
    
    redirect_to :action => :index
  end
end
