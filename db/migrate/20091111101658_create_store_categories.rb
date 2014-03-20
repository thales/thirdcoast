class CreateStoreCategories < ActiveRecord::Migration
  def self.up
    create_table :store_categories do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :store_categories
  end
end
