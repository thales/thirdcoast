class Admin::CommentsController < Admin::ApplicationController
  before_filter :load_feature 
  layout "admin"
  
  
  def index
    @comments = @feature.comments.paginate(:page => params[:page], :per_page => 9)
  end
  
  def delete
    comment = @feature.comments.find params[:id]
    comment.is_deleted = true
    comment.save
    
    flash[:notice] = "Comment was successfully deleted"
    
    redirect_to :back
  end
  
  def undelete
    comment = @feature.comments.find params[:id]
    comment.is_deleted = false
    comment.save
    
    flash[:notice] = "Comment was successfully undeleted"
    
    redirect_to :back
  end
  
  def load_feature
    @feature = Feature.find(params[:feature_id])
  end
end