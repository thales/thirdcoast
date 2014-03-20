require 'test_helper'

class CommentTest < ActiveSupport::TestCase 

  should_have_db_columns :id, :title, :comment, :commentable_id, :commentable_type, :user_id, :is_deleted, :created_at, :updated_at

  should_validate_presence_of :commentable
  should_validate_presence_of :comment
  
  should_not_allow_mass_assignment_of :commentable
  should_allow_mass_assignment_of :comment
  
  should_ensure_length_in_range :comment, (1...140), :short_message => //, :long_message => //
  
  test "should not show deleted" do
    comment1 = Factory :comment
    comment1.save
    assert_equal Comment.public.count(true), 1
    comment2 = Factory :comment
    comment2.is_deleted = true
    comment2.save
    assert_equal Comment.public.count(true), 1
  end
end
