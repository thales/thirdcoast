class Admin::UsersController < Admin::ApplicationController
  layout "admin"
  before_filter :require_super_admin_role

  def index
   @users = User.find :all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default admin_users_url
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]) # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to admin_user_url
    else
      render :action => :edit
    end
  end
end
