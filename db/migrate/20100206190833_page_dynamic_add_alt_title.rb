class PageDynamicAddAltTitle < ActiveRecord::Migration
  def self.up
    add_column :page_dynamics, :alternative_title, :string
  end

  def self.down
    remove_column :page_dynamics, :alternative_title
  end
end
