class ExtraAudioFileName < ActiveRecord::Migration
  def self.up
    add_column :extra_audio_files, :name, :string
    
    ExtraAudioFile.all.each do |file|
      file.name = file.mp3_file_name
      file.save!
    end
  end

  def self.down
    remove_column :extra_audio_files, :name
  end
end
