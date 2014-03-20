class Admin::CompetitionAwardsController < Admin::ApplicationController
  layout 'admin'
  
  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]
  
  def new
    @award = CompetitionAward.new
  end
  
  def create
    @award = Competition.find(params[:competition_id]).editions.find(params[:edition_id]).awards.new params[:competition_award]
    
    if @award.save
      redirect_to admin_competition_edition_path(params[:competition_id], params[:edition_id])
    else
      render :action => "new"
    end
  end
  
  def edit
    @award = Competition.find(params[:competition_id]).editions.find(params[:edition_id]).awards.find(params[:id])
  end
  
  def update
    @award = Competition.find(params[:competition_id]).editions.find(params[:edition_id]).awards.find(params[:id])
    
    if @award.update_attributes(params[:competition_award])
      redirect_to admin_competition_edition_path(params[:competition_id], params[:edition_id])
    else
      render :action => "edit"
    end
  end
  
  def reorder_save
    edition = Competition.find(params[:competition_id]).editions.find(params[:edition_id])
    
    params[:awards].each_with_index do |award_id, position|
      award = edition.awards.find award_id
      award.position = position
      award.save!
    end
    
    redirect_to admin_competition_edition_path(params[:competition_id], params[:edition_id])
  end
end
