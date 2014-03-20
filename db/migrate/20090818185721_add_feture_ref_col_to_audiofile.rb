class AddFetureRefColToAudiofile < ActiveRecord::Migration
  def self.up
    add_column  :audio_files, :feature_id, :integer
  end

  def self.down
  end
end


