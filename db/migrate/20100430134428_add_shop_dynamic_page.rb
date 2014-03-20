class AddShopDynamicPage < ActiveRecord::Migration
  def self.up
    page = PageDynamic.find_by_slug("shoppe")
    unless page.nil?
      page.controller = "shoppe"
      page.action = "index"
      page.save!
    end
  end

  def self.down
  end
end
