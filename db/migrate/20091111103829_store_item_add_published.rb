class StoreItemAddPublished < ActiveRecord::Migration
  def self.up
    add_column :store_items, :published, :boolean, :default => false
    add_index :store_items, :published
  end

  def self.down
    remove_column :store_items, :published
  end
end
