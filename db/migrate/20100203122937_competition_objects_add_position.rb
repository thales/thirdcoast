class CompetitionObjectsAddPosition < ActiveRecord::Migration
  def self.up
    add_column :competition_awards, :position, :integer, :default => 0
    add_column :competition_editions, :position, :integer, :default => 0
    
    add_index :competition_awards, :position
    add_index :competition_editions, :position
  end

  def self.down
    remove_column :competition_editions, :position
    remove_column :competition_awards, :position
  end
end
