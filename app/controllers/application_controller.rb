# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user
  
  before_filter :check_donate_popup
  # before_filter { Jammit.packager.precache_all } if Rails.env.development?

  private
  
    def check_donate_popup

       @popup = false
       if cookies[:popup]
         diff = Time.now.to_i - cookies[:popup].to_i 
         if diff > 21600
           cookies[:popup] = Time.now.to_i
           @popup = true
         end
       else
         cookies[:popup] = Time.now.to_i
         @popup = true
       end



      unless cookies[:alreadybegged]
        @beg = true
      end
    end
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_admin_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to admin_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end
    
  
end
