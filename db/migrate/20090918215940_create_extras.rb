class CreateExtras < ActiveRecord::Migration
  def self.up
    create_table :extras do |t|
      t.string :behind_the_scene_text

      t.timestamps
    end
  end

  def self.down
    drop_table :extras
  end
end
