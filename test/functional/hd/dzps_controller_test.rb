require 'test_helper'

class Hd::DzpsControllerTest < ActionController::TestCase
  setup do
    @hd_dzp = hd_dzps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hd_dzps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hd_dzp" do
    assert_difference('Hd::Dzp.count') do
      post :create, hd_dzp: { description: @hd_dzp.description, pic_uuid: @hd_dzp.pic_uuid, title: @hd_dzp.title, url: @hd_dzp.url }
    end

    assert_redirected_to hd_dzp_path(assigns(:hd_dzp))
  end

  test "should show hd_dzp" do
    get :show, id: @hd_dzp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hd_dzp
    assert_response :success
  end

  test "should update hd_dzp" do
    put :update, id: @hd_dzp, hd_dzp: { description: @hd_dzp.description, pic_uuid: @hd_dzp.pic_uuid, title: @hd_dzp.title, url: @hd_dzp.url }
    assert_redirected_to hd_dzp_path(assigns(:hd_dzp))
  end

  test "should destroy hd_dzp" do
    assert_difference('Hd::Dzp.count', -1) do
      delete :destroy, id: @hd_dzp
    end

    assert_redirected_to hd_dzps_path
  end
end
