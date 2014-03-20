When /^site is setup$/ do
  Page.create :title => "Store", :controller=>"store", :action=>"index"
end

Given /^I am logged in$/ do
  role = Role.create :name => "Super Admin"
  
  User.create :login => "admin", :email => "test@email.com", :password => "asdasd", :password_confirmation => "asdasd",
    :role => role
    
  Given "I am on admin login"
  When 'I fill in "user_session_login" with "admin"'
  And 'I fill in "user_session_password" with "asdasd"'
  And 'I press "user_session_submit"'
end