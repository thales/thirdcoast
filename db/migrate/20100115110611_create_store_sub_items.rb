class CreateStoreSubItems < ActiveRecord::Migration
  def self.up
    create_table :store_sub_items do |t|
      t.string :title
      t.integer :price
      t.integer :quantity
      t.references :item

      t.timestamps
    end

    add_index :store_sub_items, :item_id
    add_index :store_sub_items, :quantity
  end

  def self.down
    drop_table :store_sub_items
  end
end
