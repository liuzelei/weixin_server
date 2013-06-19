require 'test_helper'

class Hd::GgkHistoriesControllerTest < ActionController::TestCase
  setup do
    @hd_ggk_history = hd_ggk_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hd_ggk_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hd_ggk_history" do
    assert_difference('Hd::GgkHistory.count') do
      post :create, hd_ggk_history: { prize: @hd_ggk_history.prize, sn_code: @hd_ggk_history.sn_code, status: @hd_ggk_history.status, used_at: @hd_ggk_history.used_at, weixin_user_id: @hd_ggk_history.weixin_user_id }
    end

    assert_redirected_to hd_ggk_history_path(assigns(:hd_ggk_history))
  end

  test "should show hd_ggk_history" do
    get :show, id: @hd_ggk_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hd_ggk_history
    assert_response :success
  end

  test "should update hd_ggk_history" do
    put :update, id: @hd_ggk_history, hd_ggk_history: { prize: @hd_ggk_history.prize, sn_code: @hd_ggk_history.sn_code, status: @hd_ggk_history.status, used_at: @hd_ggk_history.used_at, weixin_user_id: @hd_ggk_history.weixin_user_id }
    assert_redirected_to hd_ggk_history_path(assigns(:hd_ggk_history))
  end

  test "should destroy hd_ggk_history" do
    assert_difference('Hd::GgkHistory.count', -1) do
      delete :destroy, id: @hd_ggk_history
    end

    assert_redirected_to hd_ggk_histories_path
  end
end
