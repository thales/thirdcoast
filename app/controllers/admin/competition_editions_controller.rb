class Admin::CompetitionEditionsController < Admin::ApplicationController
  layout "admin"
  
  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]
  
  def new
    @edition = CompetitionEdition.new
  end
  
  def create
    @edition = Competition.find(params[:competition_id]).editions.new params[:competition_edition]
    
    if @edition.save
      redirect_to admin_competition_edition_path(params[:competition_id], @edition)
    else
      render :action => "new"
    end
  end
  
  def show
    @edition = Competition.find(params[:competition_id]).editions.find(params[:id])
  end
  
  def edit
    @edition = Competition.find(params[:competition_id]).editions.find(params[:id])
  end
  
  def update
    @edition = Competition.find(params[:competition_id]).editions.find(params[:id])
    
    if @edition.update_attributes(params[:competition_edition])
      redirect_to :action => "show"
    else
      render :action => "edit"
    end
  end
  
  
  def reorder_save
    competition = Competition.find(params[:competition_id])
    
    params[:editions].each_with_index do |edition_id, position|
      edition = competition.editions.find edition_id
      edition.position = position
      edition.save!
    end
    
    redirect_to admin_competition_path(competition)
  end
  
end
