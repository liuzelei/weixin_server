require 'test_helper'

class ReplyTextsControllerTest < ActionController::TestCase
  setup do
    @reply_text = reply_texts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reply_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reply_text" do
    assert_difference('ReplyText.count') do
      post :create, reply_text: {  }
    end

    assert_redirected_to reply_text_path(assigns(:reply_text))
  end

  test "should show reply_text" do
    get :show, id: @reply_text
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reply_text
    assert_response :success
  end

  test "should update reply_text" do
    put :update, id: @reply_text, reply_text: {  }
    assert_redirected_to reply_text_path(assigns(:reply_text))
  end

  test "should destroy reply_text" do
    assert_difference('ReplyText.count', -1) do
      delete :destroy, id: @reply_text
    end

    assert_redirected_to reply_texts_path
  end
end
