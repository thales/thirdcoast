class CreateSpotlightsTable < ActiveRecord::Migration
  def self.up
    create_table :spotlights do |t|
      t.string :key
      t.references :feature
      t.timestamps
    end
    
    add_column :features, :was_spotlighted, :boolean, :default => false
    
    Spotlight.new(:key => "weekly").save(false)
    
  end

  def self.down
    remove_column :features, :was_spotlighted
    drop_table :spotlights
  end
end
