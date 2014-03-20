class CreateStoreItem2 < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.string :title
      t.text :description
      t.belongs_to :category
      t.integer :weight, :default => 0
      t.timestamps
    end
    
    add_index :store_items, :category_id
    add_index :store_items, :weight
  end

  def self.down
    drop_table :store_items
  end
end
