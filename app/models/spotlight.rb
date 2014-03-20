class Spotlight < ActiveRecord::Base
  validates_presence_of :key
  
  belongs_to :feature
  
  validates_presence_of :feature
  
  before_validation :set_feature_id
  
  before_save :was_dirty?
  
  attr_accessor :feature_name
  
  def feature_name
    if @feature_name
      @feature_name
    elsif self.feature
      self.feature.title
    else
      ""
    end
  end
  
  after_save :set_as_spotlighted
  
  after_save :generate_image
  
  def generate_image
    return if self.feature.nil?
    
    text = self.feature.title
    
    text = text[0,35] + "..." if text.length > 35
    
    img = Magick::Image.read(RAILS_ROOT+"/public/images/embed_img.png").first
    
    gc = Magick::Draw.new
    
    gc.font_size 10
    gc.font_family "Verdana"
    gc.font_weight = Magick::BoldWeight
    
    gc.text(1, 68, text)
    
    gc.draw(img)
    
    img.write(RAILS_ROOT+"/public/system/embed_img_with_text.png")
  end
  
  private
  
    def set_as_spotlighted
      self.feature.spotlighted_dates.create :date => Date.today if @was_dirty && self.feature
    end
    
    def set_feature_id
      self.feature = Feature.find_by_title(self.feature_name)
    end
    
    def was_dirty?
      @was_dirty = false
      
      @was_dirty = true if self.new_record?
      
      @was_dirty = true if self.changed.include?("feature") || self.changed.include?("feature_id")
    end
end
