class Tag < ActiveRecord::Base
  has_and_belongs_to_many   :features, :uniq => true
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  
  def spaceless_name
    self.name.gsub /[\s]+/, '-'
  end
end
