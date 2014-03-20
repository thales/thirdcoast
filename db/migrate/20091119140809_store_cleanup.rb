class StoreCleanup < ActiveRecord::Migration
  def self.up
    remove_column :store_items, :type_id
    remove_column :store_items, :description
    add_column :store_categories, :store_type_id, :integer
  end

  def self.down
    add_column :store_items, :description, :string
    remove_column :store_categories, :store_type_id
    add_column :store_items, :type_id, :integer
  end
end
