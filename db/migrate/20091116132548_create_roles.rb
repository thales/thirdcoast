include Authlogic
class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string  :name
      t.timestamps
    end
    Role.new(:name => "Super Admin").save
    Role.new(:name => "Admin").save
    # User.create(:login => "admin", :email => "mohammad.abed@gmail.com", :password => "123456", :password_confirmation => "123456", :role_id => 1)
  end

  def self.down
    drop_table :roles
  end
end
