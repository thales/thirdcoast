require 'test_helper'

class SpotlightTest < ActiveSupport::TestCase
  test "create spotlighted date after spotlighting" do
    feature = Factory.create :feature
    
    sp = Spotlight.new :key => "weekly", :feature_name => feature.title
    
    assert sp.save
    
    assert_equal 1, sp.feature.spotlighted_dates.count
    
    assert_equal Date.today, sp.feature.spotlighted_dates.first.date
  end
  
  test "after saving twice, don't duplicate spotlighted dates" do
    feature = Factory.create :feature
    
    sp = Spotlight.new :key => "weekly", :feature_name => feature.title
    
    assert sp.save
    
    assert sp.save
    
    assert_equal 1, sp.feature.spotlighted_dates.count
    
    sp.feature_name = feature.title
    
    assert sp.save
    
    assert_equal 1, sp.feature.spotlighted_dates.count
  end
  
  test "after saving again after a while, log it as well" do
    feature = Factory.create :feature
    feature2 = Factory.create :feature, :title => "F2"
    
    sp = Spotlight.new :key => "weekly", :feature_name => feature.title
    
    assert sp.save
    
    assert_equal 1, sp.feature.spotlighted_dates.count
    
    sp.feature_name = feature2.title
    
    assert sp.save
    
    assert_equal 1, sp.feature.spotlighted_dates.count
    
    sp.feature_name = feature.title
    
    assert sp.save
    
    assert_equal 2, sp.feature.spotlighted_dates.count
    assert_equal feature.title, sp.feature.title
  end
end
