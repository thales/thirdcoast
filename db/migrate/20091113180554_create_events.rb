class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :short_description
      t.string :host
      t.date :e_date
      t.string :location
      t.text :full_description
      t.boolean :is_3rdcoastevent

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
