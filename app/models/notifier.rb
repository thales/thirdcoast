class Notifier < ActionMailer::Base
  default_url_options[:host] = "204.232.193.61"

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "admin@thirdcoastfestival.com"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_admin_password_reset_url(user.perishable_token)
  end
  
  def comment_notification(comment, user)
    subject "[ThirdCoast] Comment was posted"
    from "pidgey@thirdcoastfestival.org"
    recipients [user.email]
    body :user => user, :comment => comment
  end
  
end
