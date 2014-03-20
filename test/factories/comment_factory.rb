Factory.define :comment do |comment|
  comment.commentable {Factory :feature }
  comment.comment "Nice!"
end
