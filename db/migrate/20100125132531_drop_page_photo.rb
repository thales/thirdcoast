class DropPagePhoto < ActiveRecord::Migration
  def self.up
    drop_table :page_photos
  end

  def self.down
    create_table "page_photos", :force => true do |t|
      t.string   "name"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
