class PageDynamic < ActiveRecord::Base
  has_one :menu_item, :class_name => "MenuItem", :as => :page
  
  attr_accessor :short_description
  
  def path
    url = ""
    
    if self.slug_prefix.to_s != ""
      url += self.slug_prefix.to_s+'/'
    end
    
    url += self.slug
  end
  
  validates_presence_of :title
end
