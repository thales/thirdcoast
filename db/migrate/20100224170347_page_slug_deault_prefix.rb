class PageSlugDeaultPrefix < ActiveRecord::Migration
  def self.up
    change_column_default :pages, :slug_prefix, ""
  end

  def self.down
    change_column_default :pages, :slug_prefix, nil
  end
end
