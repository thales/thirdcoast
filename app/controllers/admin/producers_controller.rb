class Admin::ProducersController < Admin::ApplicationController
    layout "admin"

  def index

    @producers = Producer.find(:all, :order =>'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @producers }
    end
  end

  def show
    @producer = Producer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @producer }
    end
  end

  def new
    
    @producer = Producer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @producer }
    end
  end

  def edit
    @producer = Producer.find(params[:id])
  end

  # POST /producers
  # POST /producers.xml
  def create

    @producer = Producer.new(params[:producer])

    respond_to do |format|    

      if @producer.save
        flash[:notice] = 'Producer was successfully created.'
        
        format.html { redirect_to(admin_producer_path(@producer)) }
        format.xml  { render :xml => @producer, :status => :created, :location => @producer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @producer.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @producer = Producer.find(params[:id])

    respond_to do |format|
      if @producer.update_attributes(params[:producer])
        flash[:notice] = 'Producer was successfully updated.'
        format.html { redirect_to(admin_producer_path(@producer)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @producer.errors, :status => :unprocessable_entity }
      end
    end
  end

 def show_producers_for_feature
   @producers = Producer.paginate(:per_page => 20, :page => params[:page], :order => 'name') 
  render "show_producers_for_feature"
 end

  def destroy
    @producer = Producer.find(params[:id])
    
    if @producer.deletable?
      @producer.deleted = true
      @producer.save
    end
    
    redirect_to :action => "index"
  end
end
