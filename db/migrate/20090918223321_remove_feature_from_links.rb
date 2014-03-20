class RemoveFeatureFromLinks < ActiveRecord::Migration
  def self.up
    remove_column :links, :feature_id
  end

  def self.down
  end
end
