class AddFieldsToIndividualDoners < ActiveRecord::Migration
  def self.up
    add_column :individual_doners, :name, :string
  end

  def self.down
    remove_column :individual_doners, :name
  end
end
