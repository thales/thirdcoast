class Airing < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :feature
  
  validates_each :feature do |record, attr, value|
    record.errors.add(attr, "features in Re:sound library only") if record.feature && !record.feature.collections.exists?(['name LIKE ?', '%re:sound%'])
  end
  
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
  
  named_scope :recent, :order => "date DESC"
  
  named_scope :within_month, lambda{|year, month|
    date_from = Date.new(year.to_i, month.to_i)
    date_to = date_from + 1.month
    
    {:conditions => ["date >= ? AND date < ?", date_from, date_to]}
  }
  
  def self.this_week
    self.recent.first.feature
  end
  
  def self.previous_week
    self.recent.first(:offset => 1).feature
  end
  
  private
  
    def set_feature_id
      self.feature = Feature.find_by_title(self.feature_name)
    end
  
end
