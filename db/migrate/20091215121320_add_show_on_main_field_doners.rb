class AddShowOnMainFieldDoners < ActiveRecord::Migration
  def self.up
    add_column :doners, :show_on_main, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :doners, :show_on_main
  end
end
