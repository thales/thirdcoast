class CreateExtraAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :extra_audio_files do |t|
      t.text      :description
      t.integer   :length
      t.string    :mp3_file_name
      t.string    :mp3_content_type
      t.integer   :mp3_file_size
  
      t.references :extra
      t.timestamps
    end
  end

  def self.down
    drop_table :extra_audio_files
  end
end
