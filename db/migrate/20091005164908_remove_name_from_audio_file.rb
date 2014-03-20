class RemoveNameFromAudioFile < ActiveRecord::Migration
  def self.up
    remove_column :audio_files, :name
  end

  def self.down
  end
end
