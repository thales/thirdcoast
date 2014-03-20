class ShoppeController < ApplicationController
  layout "application"

  def index
    @page_title = "Shoppe"

    @top_page = Page.find_by_slug("about-tciaf")

    @store_items = StoreItem.all
    @rightimage = @top_page.slug
   	@side_bar_tile_a = SideBarTiles.find_by_displayed(0)
   	@side_bar_tile_b = SideBarTiles.find_by_displayed(1)
   	@side_bar_tile_c = SideBarTiles.find_by_displayed(2)
   	@side_bar_tile_d = SideBarTiles.find_by_displayed(3)
  end
end
