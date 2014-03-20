class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.references :parent
      t.integer :weight, :default => 0
      t.references :page, :polymorphic => true
      t.boolean :published, :default => false
      t.timestamps
    end
    
    add_index :menu_items, :parent_id
    add_index :menu_items, :published
    add_index :menu_items, :weight
    add_index :menu_items, :page_id
    add_index :menu_items, :page_type
  end

  def self.down
    drop_table :menu_items
  end
end
