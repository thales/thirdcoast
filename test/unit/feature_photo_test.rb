require 'test_helper'

class FeaturePhotoTest < ActiveSupport::TestCase
  should_belong_to :feature

  should_have_db_columns :id, :caption, :feature_id, :photo_file_name, :photo_content_type,
                         :photo_file_size, :primary, :created_at, :updated_at
end
