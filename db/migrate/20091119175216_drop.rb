class Drop < ActiveRecord::Migration
  def self.up
    drop_table :store_items
    drop_table :store_categories
  end

  def self.down
    create_table "store_categories", :force => true do |t|
      t.string   "title"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "store_type_id"
    end
    
    create_table "store_items", :force => true do |t|
      t.string   "title"
      t.integer  "price"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "published",     :default => false
      t.integer  "store_type_id"
    end
    
  end
end
