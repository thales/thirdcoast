require 'test_helper'

class PageTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :slug, :template
  
  should_belong_to :template
  
  should_have_many :parts
  
end
