class CreateFeatureSpotlightedDates < ActiveRecord::Migration
  def self.up
    create_table :feature_spotlighted_dates do |t|
      t.references :feature
      t.date :date
    end
    
    add_index :feature_spotlighted_dates, :feature_id
    
    remove_column :features, :was_spotlighted
  end

  def self.down
    add_column :features, :was_spotlighted, :boolean,   :default => false
    drop_table :feature_spotlighted_dates
  end
end
