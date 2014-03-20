require 'test_helper'

class PageTemplateTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :content
  
  test "should be ordered by title" do
    bottom = Factory :page_template, :title => 'Zxc'
    top = Factory :page_template, :title => 'Asd'
    
    assert (PageTemplate.first.id == top.id)
  end
end
