class PlayerController < ApplicationController
  layout "player"
  
  before_filter :get_feature
  
  def show
    @page_title = @feature.title
  end
  
  def print
    @print = true
    
    @page_title = @feature.title
    
    render :action => "show"
  end
  
  private
  
    def get_feature
      @feature = Feature.find params[:id]
    end

end
