class CreateStorePhotos < ActiveRecord::Migration
  def self.up
    create_table :store_photos do |t|
      t.string :name
      t.belongs_to :store_type
      
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      

      t.timestamps
    end
    
    add_index :store_photos, :store_type_id
  end

  def self.down
    remove_index :store_photos, :store_type_id
    drop_table :store_photos
  end
end
