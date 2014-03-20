class LibraryController < ApplicationController
  layout "application"
  
  before_filter :set_vars
  
  helper_method :library_sort_options, :library_selected_sort_option, :is_winners?, :library_order_url_base, :library_tag_url_helper
  
  def index
    @page_title = "Library"
    
    joins = []
    conditions = {}
    
    joins.push(:audio_file) if library_selected_sort_option == "played" || library_selected_sort_option == "duration"
    
    unless params[:tag].nil?
      joins.push(:tags) unless params[:tag].nil?
      
      conditions[:tags] = {:name => params[:tag]}
    end
    
    scope = Feature.published
    
    if params[:order_by] == "az" && !params[:begins_with].nil? 
      scope = scope.begins_with( params[:begins_with] )
    end
    
    if params[:order_by] == "duration" && !params[:begins_with].nil? 
      scope = scope.duration( params[:begins_with] )
    end
    
    if library_selected_sort_option == "premier"
      if params[:tag].nil?
        features_conditions = ["premier_date >= ?", 2000]
      else
        features_conditions = ["premier_date >= ? and tags.name = ?", 2000, params[:tag]]
      end
      
      features = scope.all :select => "DISTINCT premier_date", :order => "premier_date ASC", :conditions => features_conditions, :joins => joins

      @years_produced = features.map{|feature| feature.premier_date }
      
      params[:year] ||= @years_produced.last
      
      if params[:tag].nil?
        years_pre_conditions = ["premier_date < ?", 2000]
      else
        years_pre_conditions = ["premier_date < ? and tags.name = ?", 2000, params[:tag]]
      end
      @years_produced_pre = scope.count(:conditions => years_pre_conditions, :joins => joins) > 0
    end
    
    if !params[:year].nil?
      scope = scope.at_year(params[:year])
    end
    
    @features = scope.paginate :conditions => conditions,
      :page => params[:page],
      :per_page => items_per_page,
      :order => sort_args,
      :joins => joins
    
    @tags = Tag.all :select => 'tags.name, tags.id, count(features.id) as amount', :conditions => {:features => {:published => true}}, :joins => :features, :group => 'tags.id', :order=> 'amount DESC'
  end
  
  def collections
    joins = []
    joins.push(:audio_file) if library_selected_sort_option == "played" || library_selected_sort_option == "duration"
    conditions = {}
    
    @collection = Collection.find(params[:id])
    @competition_collection = Collection.winners_collection
    @resound_collection = Collection.find_by_name 'Re:sound'
    
    @page_title = "Library :: "+@collection.name
    
    feature_ids = @collection.features.published.map &:id
    
    scope = Feature.in_collection(@collection)

    if is_winners?
      joins.push(:competition_awards)
      joins.push(:competition_editions)

      scope = Feature.published

      params[:year] ||= Competition.first.editions.first(:order => "title DESC").title if library_selected_sort_option == "premier"
      
      unless params[:year].nil?
        conditions[:competition_editions] = {:title => params[:year]}
      end
      
    end

    if params[:order_by] == "az" && !params[:begins_with].nil? 
      scope = scope.begins_with( params[:begins_with] )
    end
    
    if params[:order_by] == "duration" && !params[:begins_with].nil? 
      scope = scope.duration( params[:begins_with] )
    end

    unless params[:tag].nil?
      scope = scope.tagged_with(params[:tag])
    end

    scope = scope.published

    
    if !is_winners? && library_selected_sort_option == "premier"
      features = scope.all :select => "DISTINCT premier_date", :order => "premier_date ASC", :conditions => ["premier_date >= ?", 2000]

      @years_produced = features.map{|feature| feature.premier_date }
      
      params[:year] ||= @years_produced.last
      
      @years_produced_pre = scope.exists? ["premier_date < ?", 2000]
    end
    
    
    if !params[:year].nil?
      scope = scope.at_year(params[:year])
    end  
    
    if @collection == @resound_collection && library_selected_sort_option == "rand"
      scope = scope.begins_with("Re:sound%")
    end
        
    if @collection == @resound_collection &&
            (sort_args.nil? ||
              (params[:order_by] == "az" &&
                (params[:begins_with].nil? || params[:begins_with] == "r")
              )
            )
      
      join = "JOIN collections_features ON collections_features.feature_id = features.id"
      
      where = "AND collections_features.collection_id = #{@collection.id} AND features.published = 1"
      
      order = ""
      
      if params[:order_by] == "az"
        order = "ORDER BY display_order, title ASC"
      end
      
      if !params[:tag].nil?
        @tag = Tag.find_by_name params[:tag]
        
        join +=  " JOIN features_tags ON features_tags.feature_id = features.id"
        where += " AND features_tags.tag_id = #{@tag.id}"
      end
      
      if !params[:begins_with].nil?
        where += " AND features.title LIKE 'r%'"
      end
      
      sql = "SELECT *, 1 as display_order FROM features #{join} WHERE title LIKE 're:sound%' #{where}
            UNION
            SELECT *, 2 as display_order FROM features #{join} WHERE title NOT LIKE 're:sound%' #{where}
            #{order}"
      
      total_entries = scope.count
      
      @features = Feature.paginate_by_sql sql, :page => params[:page], :per_page => items_per_page, :total_entries => total_entries
    else      
      @features = scope.paginate :select => "features.*", :page => params[:page], :per_page => items_per_page, :order => sort_args, :joins => joins, :conditions => conditions
    end
    
    @tags = Tag.all :select => 'tags.name, tags.id, count(features.id) as amount', :conditions => {:features => {:id => feature_ids}}, :joins => [:features], :group => 'tags.id', :order=> 'amount DESC'
    
    render :action => "index"
  end
  
  def search
    @page_title = "Library :: Search"
    
    keyword = params[:q]
    
    if keyword.match /^re(|:| )sound$/i
      keyword = '"Re:Sound"'
    end
    
    with = {}
        
    feature_ids = Feature.search_for_ids keyword, :per_page => 1000, :page => 1, :with => with
              
    @tags = Tag.all :select => 'tags.name, tags.id, count(features.id) as amount', :conditions => {:features => {:id => feature_ids}}, :joins => [:features], :group => 'tags.id', :order=> 'amount DESC'
    
    unless params[:tag].nil?
      tag_id = Tag.find_by_name(params[:tag]).id
      
      with[:tag_ids] = tag_id
    end
              
    @features = Feature.search keyword, :with => with,
              :per_page => items_per_page, 
              :page => params[:page],
              :order => "@weight DESC",
              :field_weights => { :id => 100, :title => 10, :tags => 6, :description => 4, :collections => 4, :producers => 4, :behind_the_scene_text =>4 }
    
    render :action => "index"
  end
  
  def producers_index
    @page_title = "Library :: Producers"
    
    @producers_opened = true
    
    @producers = Producer.all(:order => "name ASC")
    
    per_part = (@producers.length.to_f / 3.0).floor
    
    left = @producers.length - per_part*3;
    left1 = 0;
    left2 = 0;
  
    left1 = 1 if left > 0
    
    left2 = 1 if left > 1
    
    @part1 = @producers[0, per_part + left1]
    @part2 = @producers[(per_part + left1), per_part + left2]
    @part3 = @producers[(per_part + left1) + (per_part + left2), per_part]
  end
  
  def producer_show
    joins = []
    joins.push(:audio_file) if library_selected_sort_option == "played" || library_selected_sort_option == "duration"
    conditions = {}
    
    @producer = Producer.find(params[:id])
    
    @page_title = "Library :: Producer :: "+@producer.name
    
    feature_ids = @producer.features.published.map &:id
    
    scope = @producer.features.published
    
    @features = scope.paginate :page => params[:page], :per_page => items_per_page, :order => sort_args, :joins => joins, :conditions => conditions
        
    @tags = Tag.all :select => 'tags.name, tags.id, count(features.id) as amount', :conditions => {:features => {:id => feature_ids}}, :joins => [:features], :group => 'tags.id', :order=> 'amount DESC'
    
    render :action => "index"
  end
  
  def feed_recent
    @features = Feature.published.recent.find :all, :limit => 25
    
    @title = "Third Coast recent items"
    
    @description = "Third Coast recent items"
    
    @url_link = library_url
    
    render :action => "feed", :layout => false, :content_type => "application/rss+xml; charset=utf-8"
  end
  
  def feed_resound
    @resound_collection = Collection.find_by_name 'Re:sound'
    
    @features = @resound_collection.features.published.recent.find :all,
      :conditions => ["title LIKE ?", 'Re:sound%'],
      :limit => 25
    
    @title = "Third Coast resound"
    
    @description = "Third Coast resound"
    
    @url_link = library_collection_url(@resound_collection)
    
    render :action => "feed", :layout => false, :content_type => "application/rss+xml; charset=utf-8"
  end
  
  
  private
  
    def set_vars
      @re_sound = Feature.re_sound.first
      @rightimage = 'library'

      @top_page  = PageDynamic.find_by_slug("library")
      
      if library_selected_sort_option == 'rand'
        @random = true
      end
      
    end
    
    def library_sort_options
      if params[:action] == "search"
        [['By relevance', ""]]
      else
        [['Sort by...', ""], ['Alpha Order', 'az'], ['Year Produced','premier'], ['Most Recent', 'recent'], ['Most Played', 'played'], ['Duration', 'duration'], ['Random', 'rand']]
      end
    end
    
    def library_selected_sort_option
      if params[:action] == "search"
        'relevance'
      elsif !params[:year].nil?
        'premier'
      else
        params[:order_by] || (params[:action] == "index" ? "rand" : "premier")
      end
    end
    
    def sort_args
      if is_winners? && library_selected_sort_option == 'premier'
        "competition_awards.position ASC"
      elsif library_selected_sort_option == "recent"
        'created_at DESC'
      elsif library_selected_sort_option == 'az'
        'title ASC'
      elsif library_selected_sort_option == 'premier'
        'premier_date DESC, id DESC'
      elsif library_selected_sort_option == 'played'
        'audio_files.played DESC'
      elsif library_selected_sort_option == 'duration'
        'audio_files.duration ASC'
      elsif library_selected_sort_option == 'rand'
        'rand()'
      end
    end
    
    def is_winners?
      params[:action] == "collections" && @collection == @competition_collection
    end
    
    def library_order_url_base(skip_order = false)
      if params[:action] == "collections"
        path = library_collection_path(params[:id])
      elsif params[:action] == "producer_show"
        path = library_producer_path(params[:id])
      else
        path = library_path :order_by => nil
      end
      
      unless params[:tag].nil?
        path += "/tag/"+params[:tag]
      end
      
      path+='/order/' unless skip_order
      
      path
    end
    
    def items_per_page
      if library_selected_sort_option == "rand"
        20
      else
        10
      end
    end
    
    def library_tag_url_helper(tag)
      if params[:action] == "collections"
        path = library_collection_path(params[:id])
      elsif params[:action] == "producer_show"
        path = library_producer_path(params[:id])
      elsif params[:action] == "search"
        path = library_search_path
      else
        path = library_path :order_by => nil
      end
      
      
      path += "/tag/"+tag
      
      if params[:action] == "search"
        path += "?q="+params[:q]
      end
      
      path
    end
end
