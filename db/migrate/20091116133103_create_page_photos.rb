class CreatePagePhotos < ActiveRecord::Migration
  def self.up
    create_table :page_photos do |t|
      t.string :name

      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      
      t.timestamps
    end
  end

  def self.down
    drop_table :page_photos
  end
end
