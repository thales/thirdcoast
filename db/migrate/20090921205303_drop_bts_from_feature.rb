class DropBtsFromFeature < ActiveRecord::Migration
  def self.up
    remove_column :features, :behind_the_scene_text
  end

  def self.down
  end
end
