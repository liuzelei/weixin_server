require 'test_helper'

class Hd::GgksControllerTest < ActionController::TestCase
  setup do
    @hd_ggk = hd_ggks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hd_ggks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hd_ggk" do
    assert_difference('Hd::Ggk.count') do
      post :create, hd_ggk: { description: @hd_ggk.description, max_luck: @hd_ggk.max_luck, max_random: @hd_ggk.max_random, pic_uuid: @hd_ggk.pic_uuid, title: @hd_ggk.title, url: @hd_ggk.url }
    end

    assert_redirected_to hd_ggk_path(assigns(:hd_ggk))
  end

  test "should show hd_ggk" do
    get :show, id: @hd_ggk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hd_ggk
    assert_response :success
  end

  test "should update hd_ggk" do
    put :update, id: @hd_ggk, hd_ggk: { description: @hd_ggk.description, max_luck: @hd_ggk.max_luck, max_random: @hd_ggk.max_random, pic_uuid: @hd_ggk.pic_uuid, title: @hd_ggk.title, url: @hd_ggk.url }
    assert_redirected_to hd_ggk_path(assigns(:hd_ggk))
  end

  test "should destroy hd_ggk" do
    assert_difference('Hd::Ggk.count', -1) do
      delete :destroy, id: @hd_ggk
    end

    assert_redirected_to hd_ggks_path
  end
end
