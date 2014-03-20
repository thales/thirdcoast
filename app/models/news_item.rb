class NewsItem < ActiveRecord::Base
  default_scope :conditions => {:deleted => false}
  
  named_scope :recent_three, {:order => "created_at DESC", :limit => 3}

  validates_presence_of :title, :description

  define_index do
    indexes title ,:sortable => true
    indexes description

    set_property :delta => true
  end

end
