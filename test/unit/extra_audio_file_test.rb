require 'test_helper'

class ExtraAudioFileTest < ActiveSupport::TestCase
  should_belong_to :extra

  should_have_db_columns :id, :description, :length, :mp3_file_name, :mp3_content_type,
                         :mp3_file_size, :created_at, :updated_at, :extra_id

  should_have_instance_methods :update_length, :set_mime_type
end
