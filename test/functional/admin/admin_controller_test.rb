require 'test_helper'

class Admin::AdminControllerTest < ActionController::TestCase
 context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
  end
end
