class ExtraAudioFile < ActiveRecord::Base
  belongs_to :extra
  
  validates_presence_of :name

  require 'mime/types' 
  attr_accessor :hours, :minutes, :seconds
  before_save :update_length

   has_attached_file :mp3,
                     :storage => :s3,
                     :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                     :path => ":attachment/:id/:basename.:extension",
                     :bucket => lambda { |mp3| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}features-extra-audio" }
                      
# dev-
 validates_attachment_content_type :mp3, :content_type =>
                                          [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                          :message => 'file must be of filetype .mp3'

 validates_attachment_presence :mp3

  def update_length
      self.length = hours.to_i*3600 + minutes.to_i*60 + seconds.to_i
  end

 def set_mime_type(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.mp3 = data
 end

end
