class CleanupPages < ActiveRecord::Migration
  def self.up
    remove_column :pages, :weight
    
    remove_column :pages, :controller
    
    remove_column :pages, :action
    
    remove_column :pages, :parent_id
    
    remove_column :pages, :no_children
    
    
  end

  def self.down
    add_column :pages, :no_children, :boolean,       :default => false
    add_column :pages, :parent_id, :integer
    add_column :pages, :action, :string
    add_column :pages, :controller, :string
    add_column :pages, :weight, :integer
  end
end
