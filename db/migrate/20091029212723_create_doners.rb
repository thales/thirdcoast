class CreateDoners < ActiveRecord::Migration
  def self.up
    create_table :doners do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :doners
  end
end
