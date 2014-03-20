require 'test_helper'

class Admin::CollectionsControllerTest < ActionController::TestCase
 context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :collections
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :collection
  end

  context 'POST to create' do
    setup do
      post :create, :collection => Factory.attributes_for(:collection)
      @collection = Collection.find(:all).last
    end

    should_redirect_to('admin_collection_path(@collection)'){admin_collection_path(@collection)}
  end

  context 'GET to show' do
    setup do
      @collection = Factory(:collection)
      get :show, :id => @collection.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :collection
  end

  context 'GET to edit' do
    setup do
      @collection = Factory(:collection)
      get :edit, :id => @collection.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :collection
  end

  context 'PUT to update' do
    setup do
      @collection = Factory(:collection)
      put :update, :id => @collection.id, :collection => Factory.attributes_for(:collection)
    end
    should_redirect_to('admin_collection_path(@collection)'){admin_collection_path(@collection)}
  end

  context 'DELETE to destroy' do
    setup do
      @collection = Factory(:collection)
      delete :destroy, :id => @collection.id
    end
    should_redirect_to('admin_collections_path'){admin_collections_path}
  end
end
