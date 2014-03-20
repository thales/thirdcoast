require 'test_helper'

class CompetitionEditionTest < ActiveSupport::TestCase
  should_validate_presence_of :title
  should_validate_presence_of :competition
  
  should_belong_to :competition
  should_have_many :awards
end
