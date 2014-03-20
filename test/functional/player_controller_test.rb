require 'test_helper'

class PlayerControllerTest < ActionController::TestCase
 context 'GET to show' do
    setup do
      @extra = Factory(:extra)
      @feature = @extra.feature
      get :show, :id => @feature.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :feature
  end
end
