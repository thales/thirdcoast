class CompetitionAward < ActiveRecord::Base
  acts_as_list :scope => :edition
  default_scope :order => "position ASC"
  
  validates_presence_of :title, :edition, :feature
  
  belongs_to :edition, :class_name => "CompetitionEdition"
  belongs_to :feature
  
  before_validation :set_feature_id
  
  attr_accessor :feature_name
  
  def feature_name
    if @feature_name
      @feature_name
    elsif self.feature
      self.feature.title
    else
      ""
    end
  end
  
  private
  
    def set_feature_id
      self.feature = Feature.find_by_title(self.feature_name)
    end
end
