class CreateStaffPicks < ActiveRecord::Migration
  def self.up
    create_table :staff_picks do |t|
      t.string :name
      t.text :blip

      t.timestamps
    end
  end

  def self.down
    drop_table :staff_picks
  end
end
