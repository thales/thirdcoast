require 'test_helper'

class LibraryControllerTest < ActionController::TestCase

  context 'GET to index' do
    setup do
      @collection = Factory(:collection)
      get :index, :collections => @collection.id
    end
    should_respond_with :success
    should_render_template :index
    should_assign_to :features
  end
end
