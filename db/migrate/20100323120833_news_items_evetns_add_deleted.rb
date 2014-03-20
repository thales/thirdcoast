class NewsItemsEvetnsAddDeleted < ActiveRecord::Migration
  def self.up
    add_column :news_items, :deleted, :boolean, :default => false
    
    add_column :events, :deleted, :boolean, :default => false
    
    add_index :news_items, :deleted
    add_index :events, :deleted
  end

  def self.down
    remove_column :events, :deleted
    remove_column :news_items, :deleted
  end
end
