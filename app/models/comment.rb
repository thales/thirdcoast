class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at DESC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  # belongs_to :user
  
  validates_presence_of :commentable, :comment
  
  validates_length_of :comment, :maximum => 140
  
  attr_accessible :comment, :name, :location
  
  named_scope :public, :conditions => {:is_deleted => false}
  
  after_create :notify_admins
  
    private
    
      def notify_admins
        User.notifiable.each do |user|
          Notifier.deliver_comment_notification(self, user)
        end
      end
end
