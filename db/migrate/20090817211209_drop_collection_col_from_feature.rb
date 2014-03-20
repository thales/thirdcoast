class DropCollectionColFromFeature < ActiveRecord::Migration
  def self.up
    remove_column :features, :collection_id         
  end

  def self.down
  end
end
