class MiscImage < ActiveRecord::Base
  default_scope :order => "name ASC", :conditions => {:deleted => false}
  
  has_attached_file   :file,
                        :storage => :s3,
                        :styles => {:thumb => "50x50>"},
                        :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                        :path => ":id/:style/:basename.:extension",
                        :bucket => lambda { |mp3| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-miscellaneous-images" },
                        :s3_headers => {"Content-Type"=>"audio/mpeg"}
# dev-
  validates_attachment_content_type :file, :content_type => 
          ['image/pjpeg','image/x-png','image/png','image/gif', 'image/jpeg', 'image/jpg']  
  
  before_create :set_name
  
  def safe_destroy
    self.deleted = true
    self.file = nil
    self.save(false)
    
  end
  
  private
  
    def set_name
      if self.name.nil? || self.name.blank?
        self.name = self.file_file_name
      end
    end
end
