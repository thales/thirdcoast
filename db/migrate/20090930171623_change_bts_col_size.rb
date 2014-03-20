class ChangeBtsColSize < ActiveRecord::Migration
  def self.up
    change_column :extras, :behind_the_scene_text, :text
  end

  def self.down
  end
end
