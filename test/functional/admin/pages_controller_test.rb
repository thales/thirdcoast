require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
     get :index
    end
    should_respond_with :success
    should_assign_to :pages
  end
  
  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :page
  end
  
  context 'POST to create' do
    setup do
      post :create, :page => Factory.attributes_for(:page)
      @page = Page.find(:all).last
    end

    should_redirect_to('admin_page_path(@page)'){admin_page_path(@page)}
  end
  
  
  context 'GET to show' do
   setup do
     @page = Factory(:page)
     get :show, :id => @page.id
   end
   should_respond_with :success
   should_render_template :show
   should_assign_to :page
  end
  
  context 'GET to edit' do
   setup do
     @page = Factory(:page)
     get :edit, :id => @page.id
   end
   should_respond_with :success
   should_render_template :edit
   should_assign_to :page
  end
  
  context 'PUT to update' do
   setup do
     @page = Factory(:page)
     put :update, :id => @page.id, :page => Factory.attributes_for(:page)
   end
   should_redirect_to('admin_page_path(@page)'){admin_page_path(@page)}
  end
  
end
