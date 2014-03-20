class AddPublishedColToFeature < ActiveRecord::Migration
  def self.up
    add_column  :features,  :published,   :boolean   
  end

  def self.down
  end
end
