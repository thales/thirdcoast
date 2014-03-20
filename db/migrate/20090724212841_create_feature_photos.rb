class CreateFeaturePhotos < ActiveRecord::Migration
  def self.up
    create_table :feature_photos do |t|
      t.string :name
      t.references :feature

      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size



      t.timestamps
    end
  end

  def self.down
    drop_table :feature_photos
  end
end
