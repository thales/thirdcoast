class StoreTypeAddPaypal < ActiveRecord::Migration
  def self.up
    add_column :store_types, :paypal, :text
  end

  def self.down
    remove_column :store_types, :paypal
  end
end
