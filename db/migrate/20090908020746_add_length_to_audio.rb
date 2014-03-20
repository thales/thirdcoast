class AddLengthToAudio < ActiveRecord::Migration
  def self.up
    add_column  :audio_files,  :duration,        :integer
    add_column  :audio_files,  :downloadable,   :boolean
  end

  def self.down
  end
end
