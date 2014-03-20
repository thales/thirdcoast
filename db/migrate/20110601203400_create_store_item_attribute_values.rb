class CreateStoreItemAttributeValues < ActiveRecord::Migration
  def self.up
    create_table :store_item_attribute_values do |t|
      t.integer :store_item_attribute_id
      t.text :attribute_value
      t.timestamps
    end
  end

  def self.down
    drop_table :store_item_attribute_values
  end
end
