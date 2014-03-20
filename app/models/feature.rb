class Feature < ActiveRecord::Base
  #attr_accessor :collection_ids
  #after_save :update_collections
  
  acts_as_commentable
 
  named_scope :published, :conditions => { :published => true }
  named_scope :unpublished, :conditions => { :published => false }
  named_scope :recent, :order => "id DESC"
  named_scope :newest, :order => "updated_at DESC", :limit => 1

  named_scope :spotlight, :include => :collections,
                          :conditions => ["collections.name = 'Library Spotlight'"],
                          :limit => 1,
                          :order => "features.updated_at DESC"

  named_scope :re_sound, :include => :collections,
                          :conditions => ["collections.name = 'Re:sound'"],
                          :limit => 1,
                          :order => "features.updated_at DESC"

  named_scope :re_sound_national, :include => :collections,
                          :conditions => ["collections.id = 6"],
                          :limit => 10,
                          :order => "features.updated_at DESC"

  has_and_belongs_to_many       :collections, :order => 'name', :uniq => true 
  has_many                      :collections_features
  has_and_belongs_to_many       :categories,  :order => 'name', :uniq => true
  has_and_belongs_to_many       :tags,        :order => 'name', :uniq => true
  has_one                       :audio_file, :dependent => :destroy
  has_many                      :feature_photos, :dependent => :destroy
  has_and_belongs_to_many       :producers
  has_one                       :extra, :dependent => :destroy
  
  has_many :airings, :dependent => :destroy
  
  has_many :competition_awards, :dependent => :destroy
  has_many :competition_editions, :through => :competition_awards, :source => :edition
  
  has_many :spotlighted_dates, :class_name => "FeatureSpotlightedDate"
  
  validates_presence_of :title

  validate :validates_premier_date_type
  
  named_scope :collections, lambda{|collection_id|
    {:conditions => {:collections_features => {:collection_id => collection_id} },
                    :joins => 'INNER JOIN collections_features ON collections_features.feature_id = features.id' }
  }
  
  named_scope :in_collection, lambda{|collection|
    {:conditions => {:collections => {:id => collection.id}}, :joins => [:collections]}
  }
  
  named_scope :begins_with, lambda{|letter|
    if letter == "-"
      signs = ["-", "'",'"',".","+","!","#","$","?","|","\\","/","=","[","]","0","1","2","3","4","5","6","7","8","9"]
      
      condition_string = []
      
      signs.length.times do
        condition_string.push("title LIKE ?")
      end
      
      condition_string = condition_string.join " OR "
      
      sings_for_string = signs.map{|sign| "#{sign}%"}
      
      conditions = sings_for_string
      conditions.unshift(condition_string)
      
      {:conditions => conditions }
    else
      {:conditions => ["title LIKE ?", "#{letter}%"] }
    end
  }
  
  named_scope :at_year, lambda{|year|
    if year == "pre"
      {:conditions => ["premier_date < ?", 2000] }
    else
      {:conditions => {:premier_date => year} }
    end
  }
  
  named_scope :categories, lambda{|category_id|
    {:conditions => {:categories_features => {:category_id => category_id} },
                     :joins => 'INNER JOIN categories_features ON categories_features.feature_id = features.id' }
  }
  
  named_scope :duration, lambda{|duration_string|
    if duration_string == '10'
      condititions = ['audio_files.duration < ?', 600]
    elsif duration_string == '10-30'
      condititions = ['audio_files.duration >= ? AND audio_files.duration < ?', 600, 1800]
    elsif duration_string == '30'
      condititions = ['audio_files.duration >= ?', 1800]
    end
    
    {:conditions => condititions, :joins => :audio_file}
  }
    
  named_scope :tagged_with, lambda{|tag|
    {:joins => :tags, :conditions => {:tags => {:name => tag}}}
  }

  define_index do
    indexes :id
    indexes title,:sortable => true
    indexes description, origin_country, premier_locaction
    indexes tags(:name)
    indexes collections(:name)
    indexes categories(:name)
    indexes producers(:name)
    indexes extra(:behind_the_scene_text)
    indexes extra(:links_block)
    indexes audio_file(:mp3_file_name)
    indexes feature_photos(:caption)
    
    has tags(:id), :as => :tag_ids
    has collections(:id), :as => :collection_ids
    has categories(:id), :as => :category_ids
    has producers(:id), :as => :producer_ids
    has audio_file(:duration), :as => :duration
    has audio_file(:played), :as => :played
    
    has competition_editions(:title), :as => :editions
    
    has :published, :created_at, :updated_at, :premier_date
    
    where "published = 1"
    
    set_property :delta => true
  end

  def primary_image(size = :medium)
    self.feature_photos.primary.empty? ? "/images/pigeonplaceholder.jpg" : self.feature_photos.primary.first.photo.url(size)
  end
  
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def winner?
    return self.collections.exists?(Collection.winners_collection) if Collection.winners_collection
    
    false
  end

  protected
  def validates_premier_date_type
    errors.add_to_base "Preimier Date needs too look like this: 2004" if "/^\d{4}$/" =~ !premier_date
    #if !premier_date.blank?
  end

  
  #has_many :collection_memberships

  #after_save calleback to handle collection_ids

  #  def update_collections
  #    unless collection_ids.nil?
  #      self.collection_memberships.each do |c|
  #        c.destroy unless collection_ids.include(m.collection_id.to_s)
  #      end
  #      collection_ids.each do |i|
  #        self.collection_memberships.create(collection_d => i) unless i.blank?
  #      end
  #      reload
  #      self.collection_ids = nil
  #    end
  #  end
end
