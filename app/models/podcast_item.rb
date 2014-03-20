class PodcastItem < ActiveRecord::Base
  default_scope :deleted => false

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :duration

  has_attached_file   :file,
                        :storage => :s3,
                        :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                        :path => ":attachment/:id/:basename.:extension",
                        :bucket => lambda { |mp3| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-podcasts" },
                        :s3_headers => {"Content-Disposition" => "attachment", "Content-Type"=>"audio/mpeg"}
# dev-
  validates_attachment_content_type :file, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
    :message => 'file must be mp3!'

  named_scope :ordered, :order => "id DESC"
end
