require 'test_helper'

class Admin::DonorsControllerTest < ActionController::TestCase
   context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :donors
  end

  context 'GET to new' do
    setup do
      get :new
    end

    should_respond_with :success
    should_render_template :new
    should_assign_to :donor
  end

  context 'POST to create' do
    setup do
      post :create, :donor => Factory.attributes_for(:donor)
      @donor = Donor.find(:all).last
    end

    should_redirect_to('admin_donor_path(@donor)'){admin_donor_path(@donor)}
  end

  context 'GET to show' do
    setup do
      @donor = Factory(:donor)
      get :show, :id => @donor.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :donor
  end

  context 'GET to edit' do
    setup do
      @donor = Factory(:donor)
      get :edit, :id => @donor.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :donor
  end

  context 'PUT to update' do
    setup do
      @donor = Factory(:donor)
      put :update, :id => @donor.id, :donor => Factory.attributes_for(:donor)
    end
    should_redirect_to('admin_donor_path(@donor)'){admin_donor_path(@donor)}
  end
  
end
