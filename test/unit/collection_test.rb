require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  setup { @collection = Factory(:collection) }
  should_have_and_belong_to_many :features
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_have_db_columns :id, :name, :description, :created_at, :updated_at
  
  test "get competition collection" do
    col = Factory.create :collection, :name => "TCF Winners"
    
    assert Collection.winners_collection
    assert_equal col.id, Collection.winners_collection.id
  end
end
