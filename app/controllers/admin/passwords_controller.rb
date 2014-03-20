class Admin::PasswordsController < ApplicationController

  def edit
    render
  end
  
  def update 
    @user = @current_user 
    unless @user.valid_password?(params[:old_password]) 
      @user.errors.add :old_password, "Is not the password we have on file" 
      render :action => :edit 
      return 
    else 
      @user.password = params[:user][:password] 
      @user.password_confirmation = params[:user] [:password_confirmation] 
      if @user.save
        flash[:notice] = "Password successfully updated" 
        redirect_to account_url 
        else 
          render :action => :edit 
        end
      end
  end
end
  
  
  


