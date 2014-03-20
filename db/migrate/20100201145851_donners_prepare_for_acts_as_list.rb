class DonnersPrepareForActsAsList < ActiveRecord::Migration
  def self.up
    add_column :doners, :position, :integer
    remove_column :doners, :show_on_main
    
    add_index :doners, :position
  end

  def self.down
    add_column :doners, :show_on_main, :boolean,       :default => false, :null => false
    remove_column :doners, :position
  end
end
