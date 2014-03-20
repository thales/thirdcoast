class EventAddFlavor < ActiveRecord::Migration
  def self.up
    add_column :events, :flavor, :string, :default => "regular"
    add_index :events, :flavor
  end

  def self.down
    change_column_default :events, :flavor, nil
    remove_index :events, :flavor
    
    remove_column :events, :flavor
  end
end
