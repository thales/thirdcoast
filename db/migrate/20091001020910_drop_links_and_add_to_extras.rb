class DropLinksAndAddToExtras < ActiveRecord::Migration
  def self.up
    drop_table :links
    add_column :extras, :links_block, :text
  end
  def self.down
  end
end
