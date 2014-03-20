class Admin::AudioFilesController < Admin::ApplicationController
  before_filter :load_feature 

  layout "admin"

  def index
  end

  def show
    @audio_file = @feature.audio_file
  end

  def new
    @audio_file = AudioFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @audio_file }
    end
  end

  def create
    @audio_file = AudioFile.new(params[:audio_file])
    @audio_file.feature_id = @feature.id
    
    @feature.audio_file.destroy if @feature.audio_file && @audio_file.valid?
    
    respond_to do |format|
      if @audio_file.save
        
        flash[:notice] = "You've successfully have added an audio file"
        format.html { redirect_to admin_feature_audio_file_path(@feature) }
        format.xml  { render :xml => @audio_file, :status => :created, :location => @audio_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @audio_file.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def set_downloadable
    @feature.audio_file.toggle! :downloadable
    
    redirect_to :action => "show"
  end
  
  private

  def load_feature
    @feature = Feature.find(params[:feature_id])
  end

end
