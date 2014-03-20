class Admin::StaffPicksController < Admin::ApplicationController

  layout "admin"

  def index
    @staff_picks = StaffPick.paginate(:all, :per_page => 15, :page => params[:page], :order=>"id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_picks }
    end
  end

  # GET /staff_picks/1
  # GET /staff_picks/1.xml
  def show
    @staff_pick = StaffPick.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff_pick }
    end
  end

  # GET /staff_picks/new
  # GET /staff_picks/new.xml
  def new
    @staff_pick = StaffPick.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff_pick }
    end
  end

  # GET /staff_picks/1/edit
  def edit
    @staff_pick = StaffPick.find(params[:id])
  end

  # POST /staff_picks
  # POST /staff_picks.xml
  def create
    @staff_pick = StaffPick.new(params[:staff_pick])

    respond_to do |format|
      if @staff_pick.save
        flash[:notice] = 'StaffPick was successfully created.'
        format.html { redirect_to(admin_staff_pick_path(@staff_pick)) }
        format.xml  { render :xml => @staff_pick, :status => :created, :location => @staff_pick }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff_pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /staff_picks/1
  # PUT /staff_picks/1.xml
  def update
    @staff_pick = StaffPick.find(params[:id])

    respond_to do |format|
      if @staff_pick.update_attributes(params[:staff_pick])
        flash[:notice] = 'StaffPick was successfully updated.'
        format.html { redirect_to(admin_staff_pick_path(@staff_pick)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff_pick.errors, :status => :unprocessable_entity }
      end
    end
  end
end
