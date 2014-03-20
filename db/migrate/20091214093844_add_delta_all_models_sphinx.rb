class AddDeltaAllModelsSphinx < ActiveRecord::Migration
  def self.up
    add_column :events, :delta, :boolean, :default => true, :null => false
    add_column :news_items, :delta, :boolean, :default => true, :null => false
    add_column :doners, :delta, :boolean, :default => true, :null => false
    add_column :individual_doners, :delta, :boolean, :default => true, :null => false
    add_column :store_types, :delta, :boolean, :default => true, :null => false
    add_column :staff_picks, :delta, :boolean, :default => true, :null => false
    add_column :pages, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :events, :delta
    remove_column :news_items, :delta
    remove_column :doners, :delta
    remove_column :pages, :delta
    remove_column :staff_picks, :delta
    remove_column :store_types, :delta
    remove_column :individual_doners, :delta

  end
end
