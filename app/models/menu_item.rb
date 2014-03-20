class MenuItem < ActiveRecord::Base
  acts_as_tree :order => "weight ASC"
  
  belongs_to :page, :polymorphic => true
  
  validates_presence_of :page
  
  attr_accessor :page_static
  
  before_validation :set_page
  before_save :set_weight
  after_save :set_prefix
  
  validates_each :parent_id do |record, attribute, value|
    record.errors.add attribute, 'Page can\'t be it\'s own children!' if record.parent && record.parent.ancestor_of?(record)
  end
  
  validates_uniqueness_of :page_id, :scope => [:page_type]
  
  def path
    self.page.path
  end
  
  def is_editable?
    self.page_type == "Page"
  end
  
  def is_published?
    if self.page_type == "Page" && !self.page.published
      return false
    else
      return true
    end
  end
  
  def level
    if @level.nil?
      @level = 0
      
      scope = self
      
      while scope.parent
        @level += 1
        scope = scope.parent
      end
      
    end
    
    return @level
  end
  
  def ancestor_of?(record)
    is_ancestor = false
    
    scope = self
    
    while scope.parent
      if scope.parent_id == record.id
        is_ancestor = true
        break
      end
      
      scope = scope.parent
    end
    
    
    return is_ancestor
  end
  
  def title
    page.title
  end
  
  def alternative_title
    self.page.alternative_title
  end
  
  private
  
    def set_page
      if @page_static && self.page_type != "PageDynamic"
        self.page = Page.find_by_id @page_static.to_i
      end
    end
    
    
    def set_weight
      return unless self.weight.nil?
      max = MenuItem.maximum('weight')
      
      if max.nil?
        max = 0
      else
        max += 1
      end
      
      self.weight = max
    end
    
    def set_prefix
      if self.page
        prefix = ""
        scope = self.parent
        
        while !scope.nil?
          prefix += "/" if prefix != ""
          prefix += scope.page.slug
          scope = scope.parent
        end
        
        page = self.page
        page.slug_prefix = prefix.split('/').reverse.join('/')
        page.save
      end
    end
    
  
end
