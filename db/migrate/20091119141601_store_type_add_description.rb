class StoreTypeAddDescription < ActiveRecord::Migration
  def self.up
    add_column :store_types, :description, :text
  end

  def self.down
    remove_column :store_types, :description
  end
end
