class SideBarTiles < ActiveRecord::Base
  default_scope :deleted => false

  validates_presence_of :title

  has_attached_file   :file,
                        :storage => :s3,
                        :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
                        :path => ":attachment/:id/:basename.:extension",
                        #:bucket => lambda { |img| "#{(Rails.env.development? || Rails.env.staging? ? 'dev-' : '' )}3rdcoast-podcasts" },
                        :bucket => lambda { |img| "side-bar-tiles" },
                        :s3_headers => {"Content-Disposition" => "attachment", "Content-Type"=>"image/jpeg"}

                        validates_attachment_content_type :file, :content_type => [ 'image/jpeg', 'image/bmp', 'image/gif', 'image/png' ],
                        :message => 'file must be either a jpeg, bmp, gif, or png!'

  named_scope :ordered, :order => "id DESC"
end
