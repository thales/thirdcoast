require 'test_helper'

class AudioFileTest < ActiveSupport::TestCase
  should_belong_to :feature

  should_have_db_columns :id, :length, :mp3_file_name, :mp3_content_type,
                         :mp3_file_size, :created_at, :updated_at, :feature_id,
                         :duration, :downloadable
                         
  should_have_db_columns :played, :default => 0

  should_have_instance_methods :update_duration, :full_file_name
  
  should_validate_numericality_of :played
  should_ensure_length_at_least :played, 0
end
