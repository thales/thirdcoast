require 'test_helper'

class CompetitionAwardTest < ActiveSupport::TestCase
  should_validate_presence_of :title
  should_validate_presence_of :edition
  should_validate_presence_of :feature
  
  should_belong_to :edition
  should_belong_to :feature
end
