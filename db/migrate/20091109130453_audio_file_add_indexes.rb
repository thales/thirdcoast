class AudioFileAddIndexes < ActiveRecord::Migration
  def self.up
    add_index :audio_files, :feature_id
    add_index :audio_files, :duration
    
    add_index :features, :published
  end

  def self.down
    remove_index :features, :published
    remove_index :audio_files, :duration
    remove_index :audio_files, :feature_id
  end
end
