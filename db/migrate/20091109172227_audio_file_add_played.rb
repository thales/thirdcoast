class AudioFileAddPlayed < ActiveRecord::Migration
  def self.up
    add_column :audio_files, :played, :integer, :default => 0
    add_index :audio_files, :played
  end

  def self.down
    remove_column :audio_files, :played
  end
end
