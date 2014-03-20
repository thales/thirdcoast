class StoreCatAddNum < ActiveRecord::Migration
  def self.up
    add_column :store_categories, :num, :integer, :default => 0
  end

  def self.down
    remove_column :store_categories, :num
  end
end
