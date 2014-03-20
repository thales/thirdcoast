require 'test_helper'

class Admin::PageTemplatesControllerTest < ActionController::TestCase
  require 'test_helper'

  context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :page_templates
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :page_template
  end

  context 'POST to create' do
    setup do
      post :create, :page_template => Factory.attributes_for(:page_template)
      @page_template = PageTemplate.find(:all).last
    end

    should_redirect_to('admin_page_template_path(@page_template)'){admin_page_template_path(@page_template)}
  end

  context 'GET to show' do
    setup do
      @page_template = Factory(:page_template)
      get :show, :id => @page_template.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :page_template
  end

  context 'GET to edit' do
    setup do
      @page_template = Factory(:page_template)
      get :edit, :id => @page_template.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :page_template
  end

  context 'PUT to update' do
    setup do
      @page_template = Factory(:page_template)
      put :update, :id => @page_template.id, :page_template => Factory.attributes_for(:page_template)
    end
    should_redirect_to('admin_page_template_path(@category)'){admin_page_template_path(@page_template)}
  end

  context 'DELETE to destroy' do
    setup do
      @page_template = Factory(:page_template)
      delete :destroy, :id => @page_template.id
    end
    should_redirect_to('admin_page_templates_path'){admin_page_templates_path}
  end
end
