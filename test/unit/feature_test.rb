require 'test_helper'

class FeatureTest < ActiveSupport::TestCase

  should_have_db_columns :id, :title, :description, :created_at, :updated_at, 
                         :origin_country, :premier_locaction, :premier_date,
                         :published, :permalink


  should_validate_presence_of :title
  should_have_one :audio_file
  should_have_many :feature_photos
  should_have_one :extra
  should_have_and_belong_to_many :producers
  should_have_and_belong_to_many :tags
  should_have_and_belong_to_many :categories
  should_have_and_belong_to_many :collections
  
  should_have_many :comments
  
  should_have_many :spotlighted_dates
  
  test "is winner?" do
    feature = Factory.create :feature
    
    assert !feature.winner?
    
    col = Factory.create :collection, :name => "TCF Winners"
    
    feature.collections << Collection.winners_collection
    
    feature.reload
    
    assert feature.winner?
  end
  
  test "cleanup after destroy" do
    collection = Factory.create :collection, :name => "Re:sound"
    
    feature = Factory.create :feature
    feature.collections << collection
    
    audio_file = Factory.create :audio_file
    feature.audio_file = audio_file
    feature.save!
    
    feature_photo = Factory.create :feature_photo
    feature.feature_photos << feature_photo
    
    airing = Factory.create :airing, :feature => feature
    
    extra = Factory.create :extra
    feature.extra = extra
    feature.save!
    
    extra_audio_file = Factory.create :extra_audio_file
    feature.extra.extra_audio_files << extra_audio_file
    
    assert feature.destroy
    
    ActiveRecord::Base.connection.clear_query_cache
    
    assert !AudioFile.find_by_id(audio_file.id)
    assert !FeaturePhoto.find_by_id(feature_photo.id)
    assert !Airing.find_by_id(airing.id)
    assert !Extra.find_by_id(extra.id)
  end
end
