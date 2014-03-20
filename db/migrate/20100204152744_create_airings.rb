class CreateAirings < ActiveRecord::Migration
  def self.up
    create_table :airings do |t|
      t.date :date
      t.references :feature
      t.timestamps
    end
    
    add_index :airings, :date
  end

  def self.down
    remove_index :airings, :date
    drop_table :airings
  end
end
