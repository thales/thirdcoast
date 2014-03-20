class CreateStoreCarts < ActiveRecord::Migration
  def self.up
    create_table :store_carts do |t|
      t.string :aasm_state
      t.timestamps
    end

    add_index :store_carts, :aasm_state
  end

  def self.down
    drop_table :store_carts
  end
end
