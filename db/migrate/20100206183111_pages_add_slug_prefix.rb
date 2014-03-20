class PagesAddSlugPrefix < ActiveRecord::Migration
  def self.up
    add_column :pages, :slug_prefix, :string
  end

  def self.down
    remove_column :pages, :slug_prefix
  end
end
