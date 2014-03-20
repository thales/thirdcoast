class AddBioToProducer < ActiveRecord::Migration
  def self.up
    add_column :producers, :bio, :text    
  end

  def self.down
  end
end
