class ChangeSidebartileColumnType < ActiveRecord::Migration
  def self.up
    change_column :side_bar_tiles, :displayed, :integer
  end

  def self.down
  end
end
