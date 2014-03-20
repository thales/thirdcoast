class CreateIndividualDoners < ActiveRecord::Migration
  def self.up
    create_table :individual_doners do |t|
      t.name :string

      t.timestamps
    end
  end

  def self.down
    drop_table :individual_doners
  end
end
