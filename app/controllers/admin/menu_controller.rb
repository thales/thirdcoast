class Admin::MenuController< Admin::ApplicationController
  layout "admin"
  
  skip_before_filter :verify_authenticity_token, :only => [:reorder_save]
  
  def index
    @items = MenuItem.roots
  end
  
  def new
    @item = MenuItem.new
  end
  
  def create
    @item = MenuItem.new params[:menu_item]
    
    if @item.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def edit
    @item = MenuItem.find params[:id]
  end
  
  def update
    @item = MenuItem.find params[:id]
    
    if @item.update_attributes(params[:menu_item])
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end
  
  
  def reorder_save
    params[:menu_items].each do |item_id, options|
      p = MenuItem.find item_id
      p.parent_id = options["parent"]
      p.weight = options["weight"]
      p.save!
    end
    
    redirect_to :action => "index"
  end
  
  
end
