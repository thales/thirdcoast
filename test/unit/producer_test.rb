require 'test_helper'

class ProducerTest < ActiveSupport::TestCase
  setup { @producer = Factory(:producer) }
  should_have_and_belong_to_many :features
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_have_db_columns :id, :name, :bio, :created_at, :updated_at
  
  test "ok" do
    p = Factory.build(:producer)
    assert p.save!
  end
  
  test "not deletable if has any features" do 
    @producer = Factory.create(:producer)
    
    assert @producer.deletable?
    
    f = Factory.create :feature
    
    subject.features << f
    
    assert !@producer.reload.deletable?
    
    f.destroy
    
    assert @producer.reload.deletable?
  end
end
