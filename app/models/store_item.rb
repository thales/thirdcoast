class StoreItem < ActiveRecord::Base
#	has_many		:store_item_attr_titles, :dependent => :destroy
  default_scope :conditions => {:deleted => false}, :order => "position ASC"
  acts_as_list

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :paypal
  
  has_attached_file   :image,
                      :styles => { :small => "180x120>"},            
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                      :path => ":attachment/:id/:style/:basename.:extension",
                      :bucket => lambda { |photo| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-store-photos" }
                      
  # dev-
  validates_attachment_content_type :image, :content_type =>
          ['image/pjpeg','image/x-png','image/png','image/gif', 'image/jpeg', 'image/jpg']  
end
