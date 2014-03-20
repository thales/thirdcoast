class Admin::MiscImagesController < Admin::ApplicationController
  layout "admin"
  
  def index
    @files = MiscImage.paginate :page => params[:page], :per_page => 20
  end
  
  def new
    @file = MiscImage.new
  end
  
  def create
    @file = MiscImage.new params[:misc_image]
    
    if @file.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def destroy
    @file = MiscImage.find params[:id]
    
    @file.safe_destroy
    
    redirect_to :action => "index"
  end
end
