class EventsController < ApplicationController
  def index
    @rightimage = 'calendar'

    today = Date.today
    
    params[:year] ||= today.year
    
    params[:month] ||= today.month

    params[:year] = params[:year].to_i
    params[:month] = params[:month].to_i

    @date = Date.new params[:year], params[:month]

    @events = Event.in_month params[:year], params[:month]
    
    @page_title = "Calendar"

    if request.xhr?
      render :json => {:main => render_to_string(:partial => 'main'), :sidebar => render_to_string(:partial => 'sidebar')}
    end
  end
end
