class Admin::PagesController < Admin::ApplicationController
  layout 'admin'
  
  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]
  
  def index
    @pages = Page.all :order => "title asc"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end
  
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end
  
  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Page was successfully created.'
        format.html { redirect_to(admin_page_path(@page)) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @page = Page.find params[:id]
    
  end
  
  def edit
    @page = Page.find params[:id]
  end
  
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Page was successfully updated.'
        format.html { redirect_to(admin_page_path(@page)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def rebuild
    @page = Page.find(params[:id])
  end
  
  def rebuild_do
    @page = Page.find(params[:id])
    
    @tpl = PageTemplate.find_by_id params[:page][:template_id]
    
    if @tpl.nil?
      render :action=> "rebuild"
    else
      @page.rebuild_with(@tpl)
      
      redirect_to :action => "edit"
    end
  end
      
  def delete
    @page = Page.find params[:id]
  end
  
  def delete_do
    Page.destroy params[:id]
    
    redirect_to :action => "index"
  end
  
end
