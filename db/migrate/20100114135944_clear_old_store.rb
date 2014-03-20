class ClearOldStore < ActiveRecord::Migration
  def self.up
    drop_table :store_photos
    
    drop_table :store_types
  end

  def self.down
    create_table "store_types", :force => true do |t|
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.text     "description"
      t.text     "paypal"
      t.boolean  "delta",       :default => true, :null => false
    end
    
    create_table "store_photos", :force => true do |t|
      t.string   "name"
      t.integer  "store_type_id"
      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "credit"
      t.boolean  "primary",            :default => false
    end
    
  end
end
