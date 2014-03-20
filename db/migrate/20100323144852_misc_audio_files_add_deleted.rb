class MiscAudioFilesAddDeleted < ActiveRecord::Migration
  def self.up
    add_column :misc_audio_files, :deleted, :boolean, :default => false
    
    add_index :misc_audio_files, :deleted
  end

  def self.down
    remove_column :misc_audio_files, :deleted
  end
end
