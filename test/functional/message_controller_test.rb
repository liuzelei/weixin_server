require 'test_helper'

class MessageControllerTest < ActionController::TestCase
  test "should get io" do
    get :io
    assert_response :success
  end

end
