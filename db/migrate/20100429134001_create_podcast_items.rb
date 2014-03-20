class CreatePodcastItems < ActiveRecord::Migration
  def self.up
    create_table :podcast_items do |t|
      t.string :title
      t.text :description
      t.integer :duration

      t.string   :file_file_name
      t.string   :file_content_type
      t.integer  :file_file_size
      t.datetime :file_updated_at

      t.boolean :deleted, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :podcast_items
  end
end
