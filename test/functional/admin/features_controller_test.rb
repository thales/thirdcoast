require 'test_helper'

class Admin::FeaturesControllerTest < ActionController::TestCase

  context 'GET to index' do
    setup do
      get :index
    end
    should_render_template :index
    should_respond_with :success
    should_assign_to :features
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :feature
  end

  context 'POST to create' do
    setup do
      post :create, :feature => Factory.attributes_for(:feature)
      @feature = Feature.find(:all).last
    end

    should_redirect_to('admin_feature_path(@feature)'){admin_feature_path(@feature)}
  end

  context 'GET to show' do
    setup do
      @feature = Factory(:feature)
      get :show, :id => @feature.id
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
  end

  context "on GET to :show_collections_for_feature for collections" do
    setup do
      @feature = Factory(:feature)
      get :show, :id => @feature.id, :ref => "collections"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :show_collections_for_feature
    should_not_set_the_flash

  end

  context "on GET to :show_collections_for_feature for categories" do
    setup do
      @feature = Factory(:feature)
      get :show, :id => @feature.id, :ref => "categories"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :show_categories_for_feature
    should_not_set_the_flash

  end

  context "on GET to :show_tags_for_feature for tags" do
    setup do
      @feature = Factory(:feature)
      get :show, :id => @feature.id, :ref => "tags"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :show_tags_for_feature
    should_not_set_the_flash

  end

  context "on GET to :show_producers_for_feature for producers" do
    setup do
      @feature = Factory(:feature)
      get :show, :id => @feature.id, :ref => "producers"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :show_producers_for_feature
    should_not_set_the_flash

  end

  context 'GET to EDIT' do
    setup do
      @feature = Factory(:feature)
      get :edit, :id => @feature.id
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :edit
    should_not_set_the_flash
  end

  context "on GET to :edit_collections_for_feature for collections" do
    setup do
      @feature = Factory(:feature)
      get :edit, :id => @feature.id, :ref => "collections"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :edit_collections_for_feature
    should_not_set_the_flash

  end

  context "on GET to :edit_collections_for_feature for categories" do
    setup do
      @feature = Factory(:feature)
      get :edit, :id => @feature.id, :ref => "categories"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :edit_categories_for_feature
    should_not_set_the_flash

  end

  context "on GET to :edit_collections_for_feature for tags" do
    setup do
      @feature = Factory(:feature)
      get :edit, :id => @feature.id, :ref => "tags"
    end

    should_assign_to :feature
    should_respond_with :success
    should_render_template :edit_tags_for_feature
    should_not_set_the_flash

  end

  context 'PUT to update' do
    setup do
      @feature = Factory(:feature)
      put :update, :id => @feature.id, :feature => Factory.attributes_for(:feature)
    end
    should_redirect_to('admin_feature_path(@feature)'){admin_feature_path(@feature)}
  end

  context 'PUT to update and render :show_collections_for_feature' do
    setup do
      @feature = Factory(:feature)
      put :update, :id => @feature.id, :ref => "collections", :feature => Factory.attributes_for(:feature)
    end
    should_render_template :show_collections_for_feature
  end

  context 'PUT to update and render :show_categories_for_feature' do
    setup do
      @feature = Factory(:feature)
      put :update, :id => @feature.id, :ref => "categories", :feature => Factory.attributes_for(:feature)
    end
    should_render_template :show_categories_for_feature
  end

  context 'PUT to update and render :show_tags_for_feature' do
    setup do
      @feature = Factory(:feature)
      put :update, :id => @feature.id, :ref => "tags", :feature => Factory.attributes_for(:feature)
    end
    should_render_template :show_tags_for_feature
  end

  context 'PUT to update and render :show_producers_for_feature' do
    setup do
      @feature = Factory(:feature)
      put :update, :id => @feature.id,:producer => {:name => "MyString"} , :ref => "producers", :feature => Factory.attributes_for(:feature)
    end
    should_render_template :show_producers_for_feature
  end

  context 'DELETE to destroy' do
    setup do
      @feature = Factory(:feature)
      delete :destroy, :id => @feature.id
    end
    should_redirect_to('admin_features_path'){admin_features_path}
  end

#  context 'GET to show_producers_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      get :show_producers_for_feature, :feature_id => @feature.id
#    end
#    should_render_template :show_producers_for_feature
#    should_respond_with :success
#    should_assign_to :feature
#    should_assign_to :producers
#  end
#
#  context 'GET to new_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      get :new_producer_for_feature, :feature_id => @feature.id
#    end
#    should_render_template :new_producer_for_feature
#    should_respond_with :success
#    should_assign_to :feature
#    should_assign_to :producer
#  end
#
#  context 'PUT to create_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      get :create_producer_for_feature, :feature_id => @feature.id, :producer => Factory.attributes_for(:producer)
#    end
#
#    should_redirect_to('admin_show_producers_for_feature_path(@feature)'){admin_show_producers_for_feature_path(@feature)}
#  end
#
#  context 'GET to show_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      @producer = Factory(:producer)
#      get :show_producer_for_feature, :feature_id => @feature.id, :producer_id => @producer.id
#    end
#    should_render_template :show_producer_for_feature
#    should_respond_with :success
#    should_assign_to :feature
#    should_assign_to :producer
#  end
#
#  context 'GET to edit_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      @producer = Factory(:producer)
#      get :edit_producer_for_feature, :feature_id => @feature.id, :producer_id => @producer.id
#    end
#    should_render_template :edit_producer_for_feature
#    should_respond_with :success
#    should_assign_to :feature
#    should_assign_to :producer
#  end
#
#  context 'PUT to update_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      @producer = Factory(:producer)
#      get :update_producer_for_feature, :feature_id => @feature.id, :producer_id => @producer.id, :id => @producer.id
#    end
#    should_redirect_to('admin_show_producer_for_feature_url(@feature, @producer)'){admin_show_producer_for_feature_url(@feature, @producer)}
#  end
#
#  context 'PUT to add_existing_producer_for_feature' do
#    setup do
#      @feature = Factory(:feature)
#      @producer = Factory(:producer)
#      get :add_existing_producer_for_feature, :feature_id => @feature.id, :producer => Factory.attributes_for(:producer)
#    end
#    should_redirect_to('admin_show_producers_for_feature_path(@feature)'){admin_show_producers_for_feature_path(@feature)}
#  end
  
end

