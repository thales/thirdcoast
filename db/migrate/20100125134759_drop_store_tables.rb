class DropStoreTables < ActiveRecord::Migration
  def self.up
    drop_table :store_cart_items
    
    drop_table :store_carts
    
    drop_table :store_categories
    
    drop_table :store_items
    
    drop_table :store_photos
    
    drop_table :store_sub_items
  end

  def self.down
    create_table "store_sub_items", :force => true do |t|
      t.string   "title"
      t.integer  "price",      :default => 0
      t.integer  "quantity",   :default => 0
      t.integer  "item_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "store_photos", :force => true do |t|
      t.integer  "owner_id"
      t.string   "owner_type"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "image_file_name"
      t.string   "image_content_type"
      t.integer  "image_file_size"
      t.datetime "image_updated_at"
    end
    
    create_table "store_items", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.integer  "category_id"
      t.integer  "weight",      :default => 0
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "store_categories", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "weight",      :default => 0
    end
    
    create_table "store_carts", :force => true do |t|
      t.string   "aasm_state"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table "store_cart_items", :force => true do |t|
      t.integer  "cart_id"
      t.integer  "sub_item_id"
      t.integer  "quantity",    :default => 1
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
