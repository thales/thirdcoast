class UpdateMenuItems < ActiveRecord::Migration
  def self.up
    remove_column :menu_items, :published
    
    change_column_default :menu_items, :weight, nil
  end

  def self.down
    change_column_default :menu_items, :weight, 0
    add_column :menu_items, :published, :boolean
  end
end
