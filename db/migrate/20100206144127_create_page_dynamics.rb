class CreatePageDynamics < ActiveRecord::Migration
  def self.up
    create_table :page_dynamics do |t|
      t.string :slug_prefix
      t.string :slug
      t.string :controller
      t.string :action
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :page_dynamics
  end
end
