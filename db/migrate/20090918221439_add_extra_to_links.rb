class AddExtraToLinks < ActiveRecord::Migration
  def self.up
   add_column :links, :extra_id, :integer        
  end

  def self.down
  end
end
