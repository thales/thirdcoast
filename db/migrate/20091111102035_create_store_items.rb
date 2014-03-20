class CreateStoreItems < ActiveRecord::Migration
  def self.up
    create_table :store_items do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.belongs_to :type
      t.belongs_to :category
      t.timestamps
    end
    
    add_index :store_items, :type_id
    add_index :store_items, :category_id
  end

  def self.down
    drop_table :store_items
  end
end
