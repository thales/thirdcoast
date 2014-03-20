class StoreSubitemAddDefaults < ActiveRecord::Migration
  def self.up
    change_column_default :store_sub_items, :price, 0
    change_column_default :store_sub_items, :quantity, 0
  end

  def self.down
  end
end
