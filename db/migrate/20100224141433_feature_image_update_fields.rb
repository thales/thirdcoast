class FeatureImageUpdateFields < ActiveRecord::Migration
  def self.up
    remove_column :feature_photos, :name
    
    rename_column :feature_photos, :photo_credit, :caption
  end

  def self.down
    rename_column :feature_photos, :caption, :photo_credit
    add_column :feature_photos, :name, :string
  end
end
