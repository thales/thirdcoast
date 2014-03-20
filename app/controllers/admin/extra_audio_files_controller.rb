class Admin::ExtraAudioFilesController < Admin::ApplicationController
  layout "admin"

  before_filter :load_extra, :only => [:new, :create ] 

  def index
    @extra_audio_files = ExtraAudioFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @extra_audio_files }
    end
  end

  def show
    
    @extra_audio_file = ExtraAudioFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extra_audio_file }
    end
  end

  def new
    @extra_audio_file = @extra.extra_audio_files.build
    @feature = @extra.feature

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extra_audio_file }
    end
  end

  def edit
    @extra_audio_file = ExtraAudioFile.find(params[:id])
    @feature = @extra_audio_file.extra.feature

  end

  def create
    @extra_audio_file = @extra.extra_audio_files.build(params[:extra_audio_file])
    @extra_audio_file.set_mime_type(params[:extra_audio_file][:mp3]) unless params[:extra_audio_file][:mp3].nil?
    @feature = @extra.feature
    
    respond_to do |format|
      if @extra_audio_file.save
        flash[:notice] = 'ExtraAudioFile was successfully created.'
        format.html { redirect_to admin_feature_extra_url(@extra_audio_file.extra.feature) }
        format.xml  { render :xml => @extra_audio_file, :status => :created, :location => @extra_audio_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @extra_audio_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @extra_audio_file = ExtraAudioFile.find(params[:id])
    @feature = @extra_audio_file.extra.feature
    respond_to do |format|
      if @extra_audio_file.update_attributes(params[:extra_audio_file])
        flash[:notice] = 'ExtraAudioFile was successfully updated.'
        format.html { redirect_to admin_feature_extra_url(@feature) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @extra_audio_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @extra_audio_file = ExtraAudioFile.find(params[:id])
    @extra_audio_file.destroy
    
    redirect_to admin_feature_extra_path(:feature_id => @extra_audio_file.extra.feature)
  end

private

  def load_extra
    @extra = Extra.find(params[:extra_id])
  end

end
