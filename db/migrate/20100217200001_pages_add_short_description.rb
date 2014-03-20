class PagesAddShortDescription < ActiveRecord::Migration
  def self.up
    add_column :pages, :short_description, :string
  end

  def self.down
    remove_column :pages, :short_description
  end
end
