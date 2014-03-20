class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.integer :weight
      t.string :controller
      t.string :action
      t.belongs_to :parent
      t.timestamps
    end
    
    add_index :pages, :slug
    add_index :pages, :weight
    add_index :pages, :parent_id
    add_index :pages, :controller
    add_index :pages, :action
  end

  def self.down
    drop_table :pages
  end
end
