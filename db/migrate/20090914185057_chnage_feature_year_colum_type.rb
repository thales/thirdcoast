class ChnageFeatureYearColumType < ActiveRecord::Migration
  def self.up
    change_column :features, :premier_date, :string
  end

  def self.down
  end
end
