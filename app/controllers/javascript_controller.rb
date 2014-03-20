class JavascriptController < ApplicationController

  def set_primary_photo
    @new_primary = FeaturePhoto.find(params[:primary], :include => [:feature])
    @feature = @new_primary.feature

    @current_primary = @feature.feature_photos.primary.first
    @new_primary.primary = true

    #TODO too many db trips!
    @new_primary.save
    
    if @current_primary
      @current_primary.primary = false
      @current_primary.save
    end

     respond_to do |format|
        format.js { render :nothing => true }
    end
  end

end
