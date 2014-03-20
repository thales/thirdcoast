class Admin::AdminController < Admin::ApplicationController

  layout "admin"
  before_filter :require_user
  def index
      
  end

  def show
    render "index"
  end
end
