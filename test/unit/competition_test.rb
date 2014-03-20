require 'test_helper'

class CompetitionTest < ActiveSupport::TestCase
  should_validate_presence_of :title
  should_have_many :editions
  should_have_many :awards
end
