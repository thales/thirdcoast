class Admin::ApplicationController < ApplicationController
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  before_filter :require_user

  private

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_super_admin_role
    #    return false unless require_user

    unless current_user.super_admin?
      flash[:notice] = "You must be logged in as Admin to access this page"
      redirect_to new_admin_user_session_url
      return false
    end if current_user

  end
end
