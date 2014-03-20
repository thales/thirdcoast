class Competition < ActiveRecord::Base
  validates_presence_of :title
  
  has_many :editions, :class_name => "CompetitionEdition"
  has_many :awards, :through => :editions
end
