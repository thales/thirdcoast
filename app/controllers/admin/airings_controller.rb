class Admin::AiringsController < Admin::ApplicationController
  layout 'admin'
  
  def index
    scope = Airing
    
    scope = scope.within_month(params[:year], params[:month]) if params[:year] && params[:month]
    
    @airings = scope.paginate :page => params[:page], :per_page => 20, :order => "date DESC"
  end
  
  def new
    @airing = Airing.new
    @airing.date = Date.today
  end
  
  def create
    @airing = Airing.new params[:airing]
    
    if @airing.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def edit
    @airing = Airing.find params[:id]
  end
  
  def update
    @airing = Airing.find params[:id]
    
    if @airing.update_attributes params[:airing]
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end
  
  def feature_name
    features = Collection.first(:conditions=>['name LIKE ?', '%re:sound%']).features.all :conditions => ['title LIKE ?', '%'+params[:q]+'%']
    
    render :text => features.map{|f| f.title }.join("\n")
  end
end
