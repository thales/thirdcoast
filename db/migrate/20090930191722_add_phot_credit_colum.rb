class AddPhotCreditColum < ActiveRecord::Migration
  def self.up
    add_column :feature_photos, :photo_credit, :string
  end

  def self.down
  end
end
