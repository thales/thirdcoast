class FeaturePhoto < ActiveRecord::Base
  belongs_to   :feature
  require 'find'

  named_scope :primary, :conditions => {:primary => true}

  validates_length_of :caption, :maximum => 27

  has_attached_file   :photo,
                      :styles => { :small => "180x120>",
                                   :medium => "195x136>",
                                   # :medium => "150x150#",
                                   :large => "210x186>",
                                   :maximum => "500x340>"},            
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                      :path => ":attachment/:id/:style/:basename.:extension",
      :bucket => lambda { |photo| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}feature-photos" }
  #dev-
  after_destroy :delegate_primary
  
  validates_attachment_content_type :photo, :content_type =>
          ['image/pjpeg','image/x-png','image/png','image/gif', 'image/jpeg', 'image/jpg']  
          
  validates_attachment_presence :photo
  
  private
  
    def delegate_primary
      return unless self.primary
      
      if !self.feature.feature_photos.primary.any? && self.feature.feature_photos.any?
        new_primary = self.feature.feature_photos.first
        new_primary.primary = true
        new_primary.save!
      end
    end
end
