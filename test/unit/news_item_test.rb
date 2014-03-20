require File.dirname(__FILE__) + '/../test_helper'

class NewsItemTest < ActiveSupport::TestCase
  should_have_db_column :title
  should_have_db_column :description

  should_validate_presence_of :title, :description
end
