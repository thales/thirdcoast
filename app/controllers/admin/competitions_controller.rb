class Admin::CompetitionsController < Admin::ApplicationController
  layout "admin"
  
  def index
    @competitions = Competition.all
  end
  
  def new
    @competition = Competition.new
  end
  
  def create
    @competition = Competition.new params[:competition]
    
    if @competition.save
      redirect_to admin_competition_path(@competition)
    else
      render :action => "new"
    end
  end
  
  def show
    @competition = Competition.find params[:id]
  end
  
  def edit
    @competition = Competition.find params[:id]
  end
  
  def update
    @competition = Competition.find params[:id]
    
    if @competition.update_attributes(params[:competition])
      redirect_to :action => "show"
    else
      render :action => "edit"
    end
  end
  
  def award_feature_name
    @competition = Collection.find_by_name 'TCF Winners'      
    features = @competition.features.all :conditions => ['title LIKE ?', '%'+params[:q]+'%']
    
    render :text => features.map{|f| f.title }.join("\n")
  end
end
