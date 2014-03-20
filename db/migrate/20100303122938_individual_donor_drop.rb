class IndividualDonorDrop < ActiveRecord::Migration
  def self.up
    drop_table :individual_donors
  end

  def self.down
    create_table "individual_donors", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "name"
      t.boolean  "delta",      :default => true, :null => false
    end
    
  end
end
