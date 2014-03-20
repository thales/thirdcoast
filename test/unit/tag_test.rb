require 'test_helper'

class TagTest < ActiveSupport::TestCase
  setup { @tag = Factory(:tag) }
  should_have_and_belong_to_many :features
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_have_db_columns :id, :name, :created_at, :updated_at
  
  test "cleanup after destroying a tag" do
    tag = Factory.create :tag, :name => "Test"
    
    feature = Factory.create :feature
    
    assert_equal 0, feature.tags.length
    
    feature.tags << tag
    
    assert_equal 1, feature.tags.length
    
    tag.destroy
    
    feature.reload
    
    assert_equal 0, feature.tags.length
    
  end
end
