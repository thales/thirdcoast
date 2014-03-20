class Collection < ActiveRecord::Base

  has_and_belongs_to_many :features
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  def to_s
    self.name
  end
  
  def self.winners_collection
    # @winners_collection ||= self.find_by_name 'TCF Winners'
    self.find_by_name 'TCF Winners'
  end
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
      