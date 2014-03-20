class CreateStoreItemAttributes < ActiveRecord::Migration
  def self.up
    create_table :store_item_attributes do |t|
      t.text :attribute_name

      t.timestamps
    end
  end

  def self.down
    drop_table :store_item_attributes
  end
end
