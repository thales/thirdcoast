class PageAddIsPublished < ActiveRecord::Migration
  def self.up
    add_column :pages, :published, :boolean, :default => 0
    
    add_index :pages, :published
  end

  def self.down
    remove_index :pages, :published
    
    remove_column :pages, :published
  end
end
