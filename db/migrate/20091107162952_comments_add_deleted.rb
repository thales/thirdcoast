class CommentsAddDeleted < ActiveRecord::Migration
  def self.up
    add_column :comments, :is_deleted, :boolean, :default => false
    add_index :comments, :is_deleted
  end

  def self.down
    remove_column :comments, :deleted
  end
end
