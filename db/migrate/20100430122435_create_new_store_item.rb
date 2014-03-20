class CreateNewStoreItem < ActiveRecord::Migration
  def self.up
    # DO NOTHING
  end

  def self.down
    # DO NOTHING
  end
end

#class CreateNewStoreItem < ActiveRecord::Migration
#  def self.up
#    create_table :store_items do |t|
#      t.string :title
#      t.text :description
#      t.text :paypal
#
#      t.string   :image_file_name
#      t.string   :image_content_type
#      t.integer  :image_file_size
#      t.datetime :image_updated_at
#
#      t.boolean :deleted, :default => false
#      
#      t.integer :position, :default => 0
#
#      t.timestamps
#    end
#  end
#
#  def self.down
#    drop_table :store_items
#  end
#end
