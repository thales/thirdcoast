class CreateStoreCartItems < ActiveRecord::Migration
  def self.up
    create_table :store_cart_items do |t|
      t.references :cart
      t.references :sub_item
      t.integer :quantity, :default => 1

      t.timestamps
    end
    add_index :store_cart_items, :cart_id
    add_index :store_cart_items, :sub_item_id
    add_index :store_cart_items, :quantity
  end

  def self.down
    drop_table :store_cart_items
  end
end
