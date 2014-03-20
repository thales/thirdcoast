require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup { @category = Factory(:category) }

  should_have_and_belong_to_many :features
  should_validate_presence_of :name
  should_validate_uniqueness_of :name, :case_sensitive => false
  should_have_db_columns :id, :name, :description, :parent_id, :created_at, :updated_at

  
end
