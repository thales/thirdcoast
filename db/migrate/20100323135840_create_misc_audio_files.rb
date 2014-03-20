class CreateMiscAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :misc_audio_files do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :misc_audio_files
  end
end
