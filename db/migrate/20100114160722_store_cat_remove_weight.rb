class StoreCatRemoveWeight < ActiveRecord::Migration
  def self.up
    # add_column :store_categories, :weight, :integer, :default => 0
    remove_column :store_categories, :num
  end

  def self.down
  end
end
