require 'test_helper'

class Admin::EventsControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :events
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :event
  end

  context 'POST to create' do
    setup do
      post :create, :event => Factory.attributes_for(:event)
      @event = Event.find(:all).last
    end
    
    should_redirect_to('admin_event_path(@event)'){admin_event_path(@event)}
  end

  context 'GET to show' do
    setup do
      @event = Factory(:event)
      get :show, :id => @event.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :event
  end

  context 'GET to edit' do
    setup do
      @event = Factory(:event)
      get :edit, :id => @event.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :event
  end

  context 'PUT to update' do
    setup do
      @event = Factory(:event)
      put :update, :id => @event.id, :event => Factory.attributes_for(:event)
    end
    should_redirect_to('admin_event_path(@event)'){admin_event_path(@event)}
  end

  context 'DELETE to destroy' do
    setup do
      @event = Factory(:event)
      delete :destroy, :id => @event.id
    end
    should_redirect_to('admin_events_path'){admin_events_path}
  end
end
