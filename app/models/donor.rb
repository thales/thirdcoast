class Donor < ActiveRecord::Base
  default_scope :order => "position ASC"
  
  acts_as_list
  
  validates_presence_of :name
  
  named_scope :on_main, :limit => 3

  has_attached_file   :photo,
    :styles => { :small => "195x136>",
    :medium => "170x130>",
    :large => "210x186>"},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :path => ":attachment/:id/:style/:basename.:extension",
    :bucket => lambda { |photo| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}donor-logos" }
# dev-
  validates_attachment_content_type :photo, :content_type =>
    ['image/pjpeg','image/x-png','image/png','image/gif', 'image/jpeg', 'image/jpg']

  define_index do
    indexes name ,:sortable => true

    set_property :delta => true
  end
end
