class CreateStorePhotos2 < ActiveRecord::Migration
  def self.up
    create_table :store_photos do |t|
      t.references :owner, :polymorphic => true

      t.timestamps
    end
    
    add_index :store_photos, :owner_id
    add_index :store_photos, :owner_type
  end

  def self.down
    drop_table :store_photos
  end
end
