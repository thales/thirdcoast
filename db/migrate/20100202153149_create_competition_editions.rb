class CreateCompetitionEditions < ActiveRecord::Migration
  def self.up
    create_table :competition_editions do |t|
      t.string :title
      t.references :competition
      t.timestamps
    end
    
    add_index :competition_editions, :competition_id
  end

  def self.down
    drop_table :competition_editions
  end
end
