class UserAddNotification < ActiveRecord::Migration
  def self.up
    add_column :users, :notify_email, :boolean, :default => false
    add_index :users, :notify_email
  end

  def self.down
    remove_index :users, :notify_email
    remove_column :users, :notify_email
  end
end
