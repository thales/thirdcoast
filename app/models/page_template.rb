class PageTemplate < ActiveRecord::Base
  validates_presence_of :title, :content
  
  has_many :pagess, :foreign_key => "template_id"
  
  default_scope :order => 'title ASC'
end
