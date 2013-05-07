require 'test_helper'

class StatControllerTest < ActionController::TestCase
  test "should get keywords" do
    get :keywords
    assert_response :success
  end

end
