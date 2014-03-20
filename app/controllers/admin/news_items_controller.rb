class Admin::NewsItemsController < Admin::ApplicationController
  layout "admin"
  def index
    @news_items = NewsItem.paginate(:all,:per_page => 10, :page => params[:page], :order => "id DESC")

    respond_to do |format|
      format.html
      format.xml  { render :xml => @news_items }
    end
  end

  def show
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @news_item }
    end
  end

  def new
    @news_item = NewsItem.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @news_item }
    end
  end

  def edit
    @news_item = NewsItem.find(params[:id])
  end

  def create
    @news_item = NewsItem.new(params[:news_item])

    respond_to do |format|
      if @news_item.save
        flash[:notice] = 'News item was successfully created.'
        format.html { redirect_to(admin_news_item_path(@news_item)) }
        format.xml  { render :xml => @news_item, :status => :created, :location => @news_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      if @news_item.update_attributes(params[:news_item])
        flash[:notice] = 'News item was successfully updated.'
        format.html { redirect_to(admin_news_item_path(@news_item)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @news_item = NewsItem.find(params[:id])
    
    @news_item.deleted = true
    @news_item.save
    
    redirect_to :action => "index"
  end
end
