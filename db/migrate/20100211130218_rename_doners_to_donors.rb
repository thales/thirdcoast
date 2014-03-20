class RenameDonersToDonors < ActiveRecord::Migration
  def self.up
    rename_table :doners, :donors
    
    rename_table :individual_doners, :individual_donors
  end

  def self.down
    rename_table :individual_donors, :individual_doners
    rename_table :donors, :doners
  end
end
