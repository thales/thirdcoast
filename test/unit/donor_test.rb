require 'test_helper'

class DonorTest < ActiveSupport::TestCase
  should_have_db_columns :id, :name, :photo_file_name, :photo_content_type, :photo_file_size, :created_at, :updated_at
  should_validate_presence_of :name
end
