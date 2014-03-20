require 'test_helper'

class Admin::AudioFilesControllerTest < ActionController::TestCase
  context 'GET to show' do
    setup do
      @audio_file = Factory(:audio_file)
      @feature = @audio_file.feature
      get :show, :feature_id => @feature.id
    end

    should_assign_to :audio_file
    should_respond_with :success
    should_render_template :show
    should_not_set_the_flash
  end

  context 'GET to new' do
    setup do
      @feature = Factory(:feature)
      get :new, :feature_id =>  @feature.id
    end
    should_respond_with :success
    should_render_template :new
    should_assign_to :audio_file
  end

  context 'POST to create' do
    setup do
      @feature = Factory(:feature)
      f = Factory.attributes_for(:audio_file).merge({"mp3" => fixture_file_upload("A Perfect Circle - 3 Libras.MP3", "audio/mpeg") })
      post :create, :audio_file => f, :feature_id =>  @feature.id
      @audio_file = AudioFile.find(:all).last
    end
    should_respond_with :redirect
    should_redirect_to('admin_feature_audio_file_path(@feature)'){admin_feature_audio_file_path(@feature)}
  end

    context 'POST to create and render action new if file type not mp3' do
    setup do
      @feature = Factory(:feature)
      f = Factory.attributes_for(:audio_file).merge({"mp3" => fixture_file_upload("btnBack.jpg", "image/jpeg") })
      post :create, :audio_file => f, :feature_id =>  @feature.id
      @audio_file = AudioFile.find(:all).last
    end
    should_respond_with :success
    should_render_template :new
  end
end
