class CreateCompetitionAwards < ActiveRecord::Migration
  def self.up
    create_table :competition_awards do |t|
      t.string :title
      t.references :edition
      t.references :feature
      t.timestamps
    end
    
    add_index :competition_awards, :edition_id
    add_index :competition_awards, :feature_id
  end

  def self.down
    drop_table :competition_awards
  end
end
