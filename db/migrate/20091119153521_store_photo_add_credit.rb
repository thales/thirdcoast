class StorePhotoAddCredit < ActiveRecord::Migration
  def self.up
    add_column :store_photos, :credit, :string
  end

  def self.down
    remove_column :store_photos, :credit
  end
end
