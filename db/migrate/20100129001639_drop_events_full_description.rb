class DropEventsFullDescription < ActiveRecord::Migration
  def self.up
    remove_column :events, :full_description
  end

  def self.down
  end
end
