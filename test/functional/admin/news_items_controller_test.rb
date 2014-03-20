require 'test_helper'

class Admin::NewsItemsControllerTest < ActionController::TestCase

 context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :news_items
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :news_item
  end

  context 'POST to create' do
    setup do
      post :create, :news_item => Factory.attributes_for(:news_item)
      @news_item = NewsItem.find(:all).last
    end

    should_redirect_to('admin_news_item_path(@news_item)'){admin_news_item_path(@news_item)}
  end

  context 'GET to show' do
    setup do
      @news_item = Factory(:news_item)
      get :show, :id => @news_item.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :news_item
  end

  context 'GET to edit' do
    setup do
      @news_item = Factory(:news_item)
      get :edit, :id => @news_item.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :news_item
  end

  context 'PUT to update' do
    setup do
      @news_item = Factory(:news_item)
      put :update, :id => @news_item.id, :news_item => Factory.attributes_for(:news_item)
    end
    should_redirect_to('admin_news_item_path(@news_item)'){admin_news_item_path(@news_item)}
  end

  context 'DELETE to destroy' do
    setup do
      @news_item = Factory(:news_item)
      delete :destroy, :id => @news_item.id
    end
    should_redirect_to('admin_news_items_path'){admin_news_items_path}
  end
end
