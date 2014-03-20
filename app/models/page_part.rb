class PagePart < ActiveRecord::Base
  belongs_to :page
  
  validates_presence_of :page, :name
end
