class FeatureSpotlightedDate < ActiveRecord::Base
  belongs_to :feature
  
  validates_presence_of :feature
  validates_presence_of :date
end
