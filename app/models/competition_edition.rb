class CompetitionEdition < ActiveRecord::Base
  acts_as_list :scope => :competition
  default_scope :order => "position ASC"
  
  validates_presence_of :title, :competition
  validates_format_of :title, :with => /^([\d]{4})$/, :message => "has to be full year (e.g. 2010) "
  
  belongs_to :competition
  
  has_many :awards, :class_name => "CompetitionAward", :foreign_key => "edition_id"
end
