class User < ActiveRecord::Base
  acts_as_authentic
  
  named_scope :notifiable, :conditions => {:notify_email => true}
  
  belongs_to :role

  def super_admin?
    return self.role_id == 1
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  
end
