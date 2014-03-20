class AddDeltaColumnFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :delta, :boolean, :default => true, :null => false

  end

  def self.down
    remove_column :features, :delta
  end
end
