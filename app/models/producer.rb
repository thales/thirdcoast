class Producer < ActiveRecord::Base
  default_scope :conditions => {:deleted => false}
  
  has_and_belongs_to_many :features

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  named_scope :begins_with, lambda{|letter|
    if letter == "-"
      signs = ["-", "'",'"',".","+","!","#","$","?","|","\\","/","=","[","]","0","1","2","3","4","5","6","7","8","9"]
      
      condition_string = []
      
      signs.length.times do
        condition_string.push("name LIKE ?")
      end
      
      condition_string = condition_string.join " OR "
      
      sings_for_string = signs.map{|sign| "#{sign}%"}
      
      conditions = sings_for_string
      conditions.unshift(condition_string)
      
      {:conditions => conditions }
    else
      {:conditions => ["name LIKE ?", "#{letter}%"] }
    end
  }
  
  def deletable?
    self.features.count == 0
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
