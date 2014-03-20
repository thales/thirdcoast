class PagesAddAlternativeTitle < ActiveRecord::Migration
  def self.up
    add_column :pages, :alternative_title, :string
  end

  def self.down
    remove_column :pages, :alternative_title
  end
end
