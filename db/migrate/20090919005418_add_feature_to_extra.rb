class AddFeatureToExtra < ActiveRecord::Migration
  def self.up
    add_column :extras, :feature_id, :integer
  end

  def self.down
  end
end
