class Page < ActiveRecord::Base
  belongs_to :template, :class_name => "PageTemplate", :foreign_key => "template_id"
  
  has_many :parts, :class_name => "PagePart", :foreign_key => "page_id", :dependent => :destroy
  accepts_nested_attributes_for :parts, :allow_destroy => true
  has_one :body, :class_name => "PagePart", :foreign_key => "page_id", :conditions => "name = 'body'"
  
  validates_presence_of :title
  validates_presence_of :slug
  
  validates_presence_of :template
  
  before_validation :set_slug
  
  has_one :menu_item, :class_name => "MenuItem", :as => :page, :dependent => :destroy
  
  before_destroy :check_menu_item

  define_index do
    indexes title, :sortable => true
    indexes slug
    indexes parts(:content)

    has parts(:id), :as => :parts_ids

    set_property :delta => true
  end
  
  named_scope :published, :conditions => {:published => true}
  
  named_scope :az, :order => "title ASC"
  
  def title_with_desc
    unless self.short_description.nil? && self.short_description.blank?
      "#{title} - #{short_description}"
    else
      self.title
    end
  end
  
  def body
    return self.parts.first(:conditions => {:name => 'body'}).content if self.template.nil?
    
    doc = Nokogiri::HTML( self.template.content )
    
    doc.css("div[rel=section]").each do |section|
      section.inner_html = self.parts.first(:conditions => {:name => section.attribute('section-title').to_s }).content
    end
    
    html_matched = doc.to_s.match(/<body>((.)*)<\/body>/m)
    
    if html_matched
      return html_matched[1]
    else
      return doc.to_s
    end
  end
  
  def path
    url = ""
    
    if self.slug_prefix.to_s != ""
      url += self.slug_prefix.to_s+'/'
    end
    
    url += self.slug
  end
  
  def get_style_for(section)
    doc = Nokogiri::HTML( self.template.content )
    
    doc.css("div[rel=section][section-title=#{section}]").first.attribute('style')
  end
  
  after_create :create_parts
  
  def rebuild_with(template)
    self.template = template
    self.save
    
    self.parts.each &:destroy
    
    self.send(:create_parts)
  end
  
  def destroyable?
    self.try(:check_menu_item)
  end
  
  def parent_titles
    titles = []
    
    if self.menu_item
      scope = self.menu_item
      
      titles.push scope.page.title
      
      while scope.parent
        scope = scope.parent
        titles.push scope.page.title
      end
    else
      titles.push self.title
    end
    
    titles.reverse.map{|t| t.gsub(/\<(|\/| \/)[\w]+\>/, "")  }.join(' :: ')
  end
  
  private
  
    def create_parts
      doc = Nokogiri::HTML( self.template.content )
      
      doc.css('div[rel=section]').each do |obj|
        self.parts.create :name => obj.attribute('section-title').to_s, :content => obj.inner_html
      end
    end
    
    def set_slug
      self.title ||= ''
      
      slug_base = self.title.gsub(/\<(|\/| \/)[\w]+\>/, "").parameterize.to_s
      
      self.slug = slug_base
      
      i = 1
      if self.id
        while Page.find(:all, :conditions => ['slug = ? and id != ?', self.slug, self.id]).any? do
          i += 1
          self.slug = "#{slug_base}-#{i}"
        end
      else
        while Page.find(:all, :conditions => ['slug = ?', self.slug]).any? do
          i += 1
          self.slug = "#{slug_base}-#{i}"
        end
      end
      
    end
    
    def check_menu_item
      return !(self.menu_item && self.menu_item.children.any?)
    end
    
end
