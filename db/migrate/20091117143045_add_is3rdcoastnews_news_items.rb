class AddIs3rdcoastnewsNewsItems < ActiveRecord::Migration
  def self.up
    add_column :news_items, :is_3rdcoastnews, :boolean, :default => false
  end

  def self.down
    remove_column :news_items, :is_3rdcoastnews
  end
end
