class MiscImagesAddDeleted < ActiveRecord::Migration
  def self.up
    add_column :misc_images, :deleted, :boolean, :default => false
    
    add_index :misc_images, :deleted
  end

  def self.down
    remove_column :misc_images, :deleted
  end
end
