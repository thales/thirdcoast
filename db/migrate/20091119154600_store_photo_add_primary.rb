class StorePhotoAddPrimary < ActiveRecord::Migration
  def self.up
    add_column :store_photos, :primary, :boolean, :default => false
    
    add_index :store_photos, :primary
  end

  def self.down
    remove_index :store_photos, :primary
    remove_column :store_photos, :primary
  end
end
