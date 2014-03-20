class DropSupporters < ActiveRecord::Migration
  def self.up
    drop_table :supporters
  end

  def self.down
  end
end
