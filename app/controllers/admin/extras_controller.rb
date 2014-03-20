class Admin::ExtrasController < Admin::ApplicationController
  layout "admin"

  before_filter :load_feature, :only =>[:show, :edit]

  def index
    #TODO: remove
    @extras = Extra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @extras }
    end
  end

  def show

    @extra = @feature.extra

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extra }
    end
  end

  # GET /extras/new
  # GET /extras/new.xml
  def new
    @extra = Extra.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extra }
    end
  end

  # GET /extras/1/edit
  def edit
    @feature = Feature.find(params[:feature_id])
    @extra = @feature.extra
    render :action => "edit_links_block" if params[:ref].eql?("extra_links")

  end

  # POST /extras
  # POST /extras.xml
  def create
    @extra = Extra.new(params[:extra])
    @extra.feature_id = @feature.id

    respond_to do |format|
      if @extra.save
        flash[:notice] = 'Extra was successfully created.'
        format.html { redirect_to(admin_feature_extra_path(@feature)) }
        format.xml  { render :xml => @extra, :status => :created, :location => @extra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /extras/1
  # PUT /extras/1.xml
  def update
    @extra = Extra.find(params[:id])
    @feature = @extra.feature

    respond_to do |format|
      if @feature.extra.update_attributes(params[:extra])
        flash[:notice] = 'Extra was successfully updated.'
        format.html { redirect_to admin_feature_extra_path(@feature) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @extra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1
  # DELETE /extras/1.xml
  def destroy
    @extra = Extra.find(params[:id])
    @extra.destroy

    respond_to do |format|
      format.html { redirect_to(extras_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_feature
    @feature = Feature.find(params[:feature_id])
  end

end
