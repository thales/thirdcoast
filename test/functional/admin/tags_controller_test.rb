require 'test_helper'

class Admin::TagsControllerTest < ActionController::TestCase
 context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :tags
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :tag
  end

  context 'POST to create' do
    setup do
      post :create, :tag => Factory.attributes_for(:tag)
      @tag = Tag.find(:all).last
    end

    should_redirect_to('admin_tag_path(@tag)'){admin_tag_path(@tag)}
  end

  context 'GET to show' do
    setup do
      @tag = Factory(:tag)
      get :show, :id => @tag.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :tag
  end

  context 'GET to edit' do
    setup do
      @tag = Factory(:tag)
      get :edit, :id => @tag.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :tag
  end

  context 'PUT to update' do
    setup do
      @tag = Factory(:tag)
      put :update, :id => @tag.id, :tag => Factory.attributes_for(:tag)
    end
    should_redirect_to('admin_tag_path(@tag)'){admin_tag_path(@tag)}
  end

  context 'DELETE to destroy' do
    setup do
      @tag = Factory(:tag)
      delete :destroy, :id => @tag.id
    end
    should_redirect_to('admin_tags_path'){admin_tags_path}
  end
end
