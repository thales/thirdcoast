class Admin::FeaturePhotosController < Admin::ApplicationController
  before_filter :load_feature

  layout "admin"

  def index
    @feature = Feature.find(params[:feature_id])
    @feature_photos = @feature.feature_photos
 end

  def new                                                           
    @feature_photo = @feature.feature_photos.build
  end
                                                                                                                                
  def create
    @feature_photo = @feature.feature_photos.build(params[:feature_photo])
    @feature_photo.primary = true unless @feature.feature_photos.primary.any?
    
    if @feature_photo.save
      redirect_to admin_feature_feature_photos_url
    else
      render :action => "new"
    end
  end
  
  def destroy
    @feature_photo = @feature.feature_photos.find params[:id]
    
    @feature_photo.destroy
    
    redirect_to :action => "index"
  end

    private

      def load_feature
        @feature = Feature.find(params[:feature_id])
      end
end
