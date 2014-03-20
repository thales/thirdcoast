require 'test_helper'

class Admin::ExtrasControllerTest < ActionController::TestCase
  context 'GET to show' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature

      get :show, :feature_id =>  @feature.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :extra
  end

  context 'GET to edit' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      get :edit, :feature_id =>  @feature.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :extra
  end

  context 'GET to edit and render edit_links_block for Edit Links Block' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      get :edit, :feature_id =>  @feature.id, :ref => "extra_links"
    end
    should_respond_with :success
    should_render_template :edit_links_block
    should_assign_to :extra
  end

  context 'PUT to update' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      put :update, :id => @extra.id, :extra => Factory.attributes_for(:extra), :feature_id => @feature.id
    end
    should_redirect_to('admin_feature_extra_path(@feature)'){admin_feature_extra_path(@feature)}
  end
end
