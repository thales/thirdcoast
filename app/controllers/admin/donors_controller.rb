class Admin::DonorsController < Admin::ApplicationController
  layout "admin"
  
  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]

  def index
    @donors = Donor.paginate(:all, :per_page => 15, :page => params[:page])
  end

  def show
    @donor = Donor.find(params[:id])
  end
  
  def new
    @donor = Donor.new
  end

  def edit
    @donor = Donor.find(params[:id])
  end
  
  def destroy
    Donor.destroy params[:id]
    
    redirect_to admin_donors_path
  end
  
  def create
    @donor = Donor.new(params[:donor])

    if @donor.save
      flash[:notice] = 'Donor was successfully created.'
      redirect_to admin_donor_path(@donor)
    else
      render :action => "new"
    end
  end

  def update
    @donor = Donor.find(params[:id])

    if @donor.update_attributes(params[:donor])
      flash[:notice] = 'Donor was successfully updated.'
      redirect_to admin_donor_path(@donor)
    else
      render :action => "edit"
    end
  end
  
  def reorder
    @donors = Donor.all
    
    render :layout => false
  end
  
  def reorder_save
    params[:donors].each_with_index do |id, i|
      d = Donor.find(id)
      d.position = i
      d.save!
    end
    
    redirect_to :action => :index
  end
end
