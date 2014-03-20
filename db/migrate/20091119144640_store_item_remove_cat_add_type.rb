class StoreItemRemoveCatAddType < ActiveRecord::Migration
  def self.up
    remove_column :store_items, :category_id
    
    add_column :store_items, :store_type_id, :integer
    
    add_index :store_items, :store_type_id
  end

  def self.down
    remove_index :store_items, :store_type_id
    remove_column :store_items, :store_type_id
    add_column :store_items, :category_id, :integer, :null => false
  end
end
