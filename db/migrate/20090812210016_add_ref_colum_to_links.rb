class AddRefColumToLinks < ActiveRecord::Migration
  def self.up
    add_column    :links,  :feature_id, :integer
  end

  def self.down
  end
end
