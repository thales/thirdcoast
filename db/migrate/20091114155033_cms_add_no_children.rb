class CmsAddNoChildren < ActiveRecord::Migration
  def self.up
    add_column :pages, :no_children, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :no_children
  end
end
