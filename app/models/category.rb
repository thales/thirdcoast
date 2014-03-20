class Category < ActiveRecord::Base
  acts_as_tree :order => "name"
  has_and_belongs_to_many :features
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
