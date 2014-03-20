class DropSpotlight < ActiveRecord::Migration
  def self.up
    drop_table :spotlights
  end

  def self.down
  end
end
