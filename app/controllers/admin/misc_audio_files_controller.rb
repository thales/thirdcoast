class Admin::MiscAudioFilesController < Admin::ApplicationController
  layout "admin"
  
  def index
    @files = MiscAudioFile.paginate :page => params[:page], :per_page => 20
  end
  
  def new
    @file = MiscAudioFile.new
  end
  
  def create
    @file = MiscAudioFile.new params[:misc_audio_file]
    
    if @file.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def destroy
    @file = MiscAudioFile.find params[:id]
    
    @file.safe_destroy
    
    redirect_to :action => "index"
  end
end
