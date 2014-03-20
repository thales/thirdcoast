class AudioFile < ActiveRecord::Base
  require 'mime/types' 
  before_save :update_duration
  after_save :set_feature_delta_flag

  attr_accessor :hours, :minutes, :seconds

  before_save :update_duration

  belongs_to :feature
  
  validates_numericality_of :played, :greater_than_or_equal_to => 0

  #validates_attachment_presence :mp3
  
  has_attached_file   :mp3,
                        :storage => :s3,
                        :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                        :path => ":attachment/:id/:basename.:extension",
                        :bucket => lambda { |mp3| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-features" },
                        :s3_headers => {"Content-Disposition" => "attachment", "Content-Type"=>"audio/mpeg"}
# dev-
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
    :message => 'file must be mp3!'

  def update_duration
    self.duration = hours.to_i*3600 + minutes.to_i*60 + seconds.to_i
  end
  
  def full_file_name
    self.id.to_s + "/" + self.mp3_file_name.to_s
  end

  protected

  def set_feature_delta_flag
    feature.delta = true
    feature.save
  end

end
