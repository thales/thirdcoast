class ProducerAddDeleted < ActiveRecord::Migration
  def self.up
    add_column :producers, :deleted, :boolean, :default => false
    
    add_index :producers, :deleted
  end

  def self.down
    remove_column :producers, :deleted
  end
end
