class AddPermalinkToFeature < ActiveRecord::Migration
  def self.up
    add_column :features, :permalink, :string
  end

  def self.down
  end
end
