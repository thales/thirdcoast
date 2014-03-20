require 'test_helper'

class FeatureSpotlightedDateTest < ActiveSupport::TestCase
  should_belong_to :feature
  should_validate_presence_of :feature
  
  should_validate_presence_of :date
end
