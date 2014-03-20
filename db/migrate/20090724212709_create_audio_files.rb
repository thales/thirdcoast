class CreateAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :audio_files do |t|
      t.string    :name
      t.integer   :length
      t.string    :mp3_file_name
      t.string    :mp3_content_type
      t.integer   :mp3_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_files
  end
end
