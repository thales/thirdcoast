require 'test_helper'

class ExtraTest < ActiveSupport::TestCase
  should_belong_to :feature
  should_have_many :extra_audio_files

  should_have_db_columns :id, :behind_the_scene_text, :feature_id, :links_block, :created_at, :updated_at

  
end
