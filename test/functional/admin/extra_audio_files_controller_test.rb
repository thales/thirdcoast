require 'test_helper'

class Admin::ExtraAudioFilesControllerTest < ActionController::TestCase
  context 'GET to new' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      get :new, :extra_id =>  @extra.id
    end
    should_respond_with :success
    should_render_template :new
    should_assign_to :extra_audio_file
    should_assign_to :feature
  end

  context 'POST to create' do
    setup do
      @extra = Factory(:extra)
      f = Factory.attributes_for(:extra_audio_file).merge({"mp3" => fixture_file_upload("A Perfect Circle - 3 Libras.MP3", "audio/mpeg") })
      post :create, :extra_audio_file => f, :extra_id =>  @extra.id
      @extra_audio_file = ExtraAudioFile.find(:all).last
    end
    should_respond_with :redirect
    should_redirect_to('admin_feature_extra_url(@extra_audio_file.extra.feature)'){admin_feature_extra_url(@extra_audio_file.extra.feature)}
  end

  context 'POST to create and render action new if file type not mp3' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      f = Factory.attributes_for(:extra_audio_file).merge({"mp3" => fixture_file_upload("btnBack.jpg", "image/jpeg") })
      post :create, :extra_audio_file => f, :extra_id =>  @extra.id
      @extra_audio_file = ExtraAudioFile.find(:all).last
    end
    should_respond_with :success
    should_render_template :new
    should_assign_to :extra_audio_file
    should_assign_to :feature
  end

  context 'GET to edit' do
    setup do
      @extra_audio_file = Factory(:extra_audio_file)
      get :edit, :id =>  @extra_audio_file.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :extra_audio_file
    should_assign_to :feature
  end
  
  context 'PUT to update' do
    setup do
      @extra_audio_file = Factory(:extra_audio_file)
      @feature = @extra_audio_file.extra.feature
      put :update, :id => @extra_audio_file.id, :extra_audio_file => Factory.attributes_for(:extra_audio_file).merge({"mp3" => fixture_file_upload("A Perfect Circle - 3 Libras.MP3", "audio/mpeg") })
    end
    should_redirect_to('admin_feature_extra_url(@feature)'){admin_feature_extra_url(@feature)}
  end

  context 'PUT to update' do
    setup do
      @extra_audio_file = Factory(:extra_audio_file)
      @feature = @extra_audio_file.extra.feature
      put :update, :id => @extra_audio_file.id, :extra_audio_file => Factory.attributes_for(:extra_audio_file).merge({"mp3" => fixture_file_upload("btnBack.jpg", "image/jpeg") })
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :extra_audio_file
    should_assign_to :feature
  end
end
