class Admin::FeaturesController < Admin::ApplicationController
  layout "admin"
  auto_complete_for :producer, :name, :limit => 15

  def index
    order = nil
    
    params[:order_by] = "recent" if params[:order_by].nil? || params[:order_by].blank?
    
    if params[:order_by].eql?('recent')
      order = 'features.created_at DESC'
    elsif params[:order_by].eql?('title')
      order = 'features.title ASC'
    elsif params[:order_by].eql?('r_updated')
      order = 'features.updated_at DESC'
    end

    unless params[:collection].blank?
      @features = Feature.paginate(:all, :include => :collections, :conditions =>["features.title like ? and collections.id = ?","#{params[:char]}%",params[:collection]],
                                         :order => order, :per_page => 20, :page => params[:page])
    else
      @features = Feature.paginate(:all, :conditions =>["features.title like ?","#{params[:char]}%"],
                                         :order => order, :per_page => 20, :page => params[:page])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @features }
    end
  end

  def show
    @feature = Feature.find(params[:id])
    @producer = Producer.new if params[:ref].eql?("producers")

    respond_to do |format|
      format.html {render :action => 'show_collections_for_feature'} if params[:ref].eql?("collections")
      format.html {render :action => 'show_categories_for_feature'} if params[:ref].eql?("categories")
      format.html {render :action => 'show_tags_for_feature'} if params[:ref].eql?("tags")
      format.html {render :action => 'show_producers_for_feature'} if params[:ref].eql?("producers")
      format.html if params[:ref].nil?
      format.xml  { render :xml => @feature }
    end
  end

  def new
    @feature = Feature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feature }
    end
  end

  def edit
    @feature = Feature.find(params[:id])
    render :action => 'edit_collections_for_feature' if params[:ref].eql?("collections")
    render :action => 'edit_categories_for_feature' if params[:ref].eql?("categories")
    render :action => 'edit_tags_for_feature' if params[:ref].eql?("tags")
  end

  def create
    @feature = Feature.new(params[:feature])

    respond_to do |format|
      if @feature.save
        @extra = Extra.new
        @extra.feature = @feature
        @extra.save
        flash[:notice] = 'Feature was successfully created.'
        format.html { redirect_to(admin_feature_url(@feature)) }
        format.xml  { render :xml => @feature, :status => :created, :location => @feature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @feature = Feature.find(params[:id])
    if params[:ref].eql?("producers")
      @producer = Producer.find_by_name(params[:producer][:name])
      params[:feature][:producer_ids] = @producer.nil? ? @feature.producer_ids : @feature.producer_ids.push(@producer.id)

    end

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        flash[:notice] = 'Feature was successfully updated.'
        format.html { render :action => "show_collections_for_feature" } if params[:ref].eql?("collections")
        format.html { render :action => "show_categories_for_feature" } if params[:ref].eql?("categories")
        format.html { render :action => "show_tags_for_feature" } if params[:ref].eql?("tags")
        format.html {render :action => 'show_producers_for_feature'} if params[:ref].eql?("producers")
        format.html { redirect_to(admin_feature_url(@feature)) } if params[:ref].nil?
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  def pre_delete
    @feature = Feature.find params[:id]
  end
  # DELETE /features/1
  # DELETE /features/1.xml
  def destroy
    Feature.destroy params[:id]

    redirect_to(admin_features_url)
  end
  
  def remove_producer
    @feature = Feature.find params[:feature_id]
    
    @feature.producers.delete Producer.find(params[:producer_id])
    
    redirect_to admin_feature_url(@feature, :ref => "producers")
  end
  
  def autocomplete_name
    features = Feature.all :conditions => ['title LIKE ?', '%'+params[:q]+'%']
    
    render :text => features.map{|f| f.title }.join("\n")
  end
  
  def search
    @features = Feature.paginate :conditions => ['title LIKE ?', '%'+params[:q]+'%'], :order => "title ASC",
          :page => params[:page], :per_page => 20
    
    case @features.count
      when 0
        render "not_found"
      when 1
        redirect_to admin_feature_url(@features.first)
      else
        render "index"
    end
  end
end
