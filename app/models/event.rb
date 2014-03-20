class Event < ActiveRecord::Base
  default_scope :conditions => {:deleted => false}
  validates_presence_of :name
  
  named_scope :upcoming, lambda{
    date = Date.today - 1.day
    
    {:conditions => ['e_date > ?', date], :order => "e_date ASC", :limit => 2}
  }
  
  validates_presence_of :flavor

  has_attached_file   :photo,
    :styles => { :small => "195x136>",
    :medium => "170x130>",
    :large => "210x186>"},
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml",
    :path => ":attachment/:id/:style/:basename.:extension",
    :bucket => lambda { |photo| "#{(Rails.env.development? || Rails.env.staging? ? '' : '' )}3rdcoast-events-pix" }
# dev-
  validates_attachment_content_type :photo, :content_type =>
    ['image/pjpeg','image/x-png','image/png','image/gif', 'image/jpeg', 'image/jpg']

  def self.in_month(year, month)
    from = Date.new(year, month, 1)
    to = Date.new(year, month, 1) + 1.month - 1.day

    self.all :conditions => {:e_date => from..to}, :order => 'e_date ASC'
  end
  
  def formatted_date
    self.e_date.nil? ? nil : self.e_date.strftime('%A %-1m/%-1d/%y')
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def deadline?
    self.flavor == "deadline"
  end
  
  define_index do
    indexes name ,:sortable => true
    indexes short_description
    indexes host
    indexes location
    set_property :delta => true
  end



end
