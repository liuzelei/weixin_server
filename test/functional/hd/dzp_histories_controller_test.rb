require 'test_helper'

class Hd::DzpHistoriesControllerTest < ActionController::TestCase
  setup do
    @hd_dzp_history = hd_dzp_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hd_dzp_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hd_dzp_history" do
    assert_difference('Hd::DzpHistory.count') do
      post :create, hd_dzp_history: { dzp_id: @hd_dzp_history.dzp_id, prize: @hd_dzp_history.prize, sn_code: @hd_dzp_history.sn_code, status: @hd_dzp_history.status, used_at: @hd_dzp_history.used_at, weixin_user_id: @hd_dzp_history.weixin_user_id }
    end

    assert_redirected_to hd_dzp_history_path(assigns(:hd_dzp_history))
  end

  test "should show hd_dzp_history" do
    get :show, id: @hd_dzp_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hd_dzp_history
    assert_response :success
  end

  test "should update hd_dzp_history" do
    put :update, id: @hd_dzp_history, hd_dzp_history: { dzp_id: @hd_dzp_history.dzp_id, prize: @hd_dzp_history.prize, sn_code: @hd_dzp_history.sn_code, status: @hd_dzp_history.status, used_at: @hd_dzp_history.used_at, weixin_user_id: @hd_dzp_history.weixin_user_id }
    assert_redirected_to hd_dzp_history_path(assigns(:hd_dzp_history))
  end

  test "should destroy hd_dzp_history" do
    assert_difference('Hd::DzpHistory.count', -1) do
      delete :destroy, id: @hd_dzp_history
    end

    assert_redirected_to hd_dzp_histories_path
  end
end
