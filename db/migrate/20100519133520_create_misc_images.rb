class CreateMiscImages < ActiveRecord::Migration
  def self.up
    create_table :misc_images do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :misc_images
  end
end
