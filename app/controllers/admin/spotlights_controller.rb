class Admin::SpotlightsController < Admin::ApplicationController
  layout "admin"
  
  def show
    @spotlight = Spotlight.find_by_key "weekly"
    
    if params[:order] == "az"
      order = "features.title ASC"
    else
      order_params = "date DESC, id DESC"
    end
    
    @spotlight_dates = FeatureSpotlightedDate.paginate :all, :order => order_params, :include => [:feature],
          :page => params[:page], :per_page => 15
  end
  
  def edit
    @spotlight = Spotlight.find_by_key "weekly"
  end
  
  def update
    @spotlight = Spotlight.find_by_key "weekly"
    
    if @spotlight.update_attributes(params[:spotlight])
      redirect_to :action => "show"
    else
      render :action => "edit"
    end
  end
  
  def feature_name
    features = Collection.first(:conditions=>['name LIKE ?', '%spotlight%']).features.all :conditions => ['title LIKE ?', '%'+params[:q]+'%']
    
    render :text => features.map{|f| f.title }.join("\n")
  end
end
