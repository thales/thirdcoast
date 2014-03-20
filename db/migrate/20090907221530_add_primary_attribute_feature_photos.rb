class AddPrimaryAttributeFeaturePhotos < ActiveRecord::Migration
  def self.up
    add_column :feature_photos, :primary, :boolean
  end

  def self.down
  end
end
