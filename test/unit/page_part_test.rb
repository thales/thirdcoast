require 'test_helper'

class PagePartTest < ActiveSupport::TestCase
  should_belong_to :page
  should_validate_presence_of :page, :name
end
