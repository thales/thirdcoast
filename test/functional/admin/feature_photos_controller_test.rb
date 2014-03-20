require 'test_helper'

class Admin::FeaturePhotosControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      @feature = Factory(:feature)
      get :index, :feature_id =>  @feature.id
    end
    should_respond_with :success
    should_assign_to :feature_photos
  end

  context 'GET to new' do
    setup do
      @feature = Factory(:feature)
      get :new, :feature_id =>  @feature.id
    end
    should_respond_with :success
    should_render_template :new
    should_assign_to :feature_photo
  end

  context 'POST to create' do
    setup do
      @feature = Factory(:feature)
      post :create, :feature_photo => Factory.attributes_for(:feature_photo), :feature_id =>  @feature.id
      @feature_photo = FeaturePhoto.find(:all).last
    end
    should_redirect_to('admin_feature_feature_photos_url'){admin_feature_feature_photos_url}
  end

end
