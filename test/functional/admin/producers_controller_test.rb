require 'test_helper'

class Admin::ProducersControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :producers
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :producer
  end

  context 'POST to create' do
    setup do
      post :create, :producer => Factory.attributes_for(:producer)
      @producer = Producer.find(:all).last
    end

    should_redirect_to('admin_producer_path(@producer)'){admin_producer_path(@producer)}
  end

  context 'GET to show' do
    setup do
      @producer = Factory(:producer)
      get :show, :id => @producer.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :producer
  end

  context 'GET to edit' do
    setup do
      @producer = Factory(:producer)
      get :edit, :id => @producer.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :producer
  end

  context 'PUT to update' do
    setup do
      @producer = Factory(:producer)
      put :update, :id => @producer.id, :producer => Factory.attributes_for(:producer)
    end
    should_redirect_to('admin_producer_path(@producer)'){admin_producer_path(@producer)}
  end

  context 'DELETE to destroy' do
    setup do
      @producer = Factory(:producer)
      delete :destroy, :id => @producer.id
    end
    should_redirect_to('admin_producers_path'){admin_producers_path}
  end
end
