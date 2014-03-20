require 'test_helper'

class Admin::StaffPicksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staff_picks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff_pick" do
    assert_difference('StaffPick.count') do
      post :create, :staff_pick => {:name => "Test", :blip => "Description" }
    end

    assert_redirected_to admin_staff_pick_path(assigns(:staff_pick))
  end

  test "should show staff_pick" do
    get :show, :id => staff_picks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => staff_picks(:one).to_param
    assert_response :success
  end

  test "should update staff_pick" do
    put :update, :id => staff_picks(:one).to_param, :staff_pick => { }
    assert_redirected_to admin_staff_pick_path(assigns(:staff_pick))
  end
end
