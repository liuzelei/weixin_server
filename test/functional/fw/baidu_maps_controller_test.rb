require 'test_helper'

class Fw::BaiduMapsControllerTest < ActionController::TestCase
  setup do
    @fw_baidu_map = fw_baidu_maps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fw_baidu_maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fw_baidu_map" do
    assert_difference('Fw::BaiduMap.count') do
      post :create, fw_baidu_map: { description: @fw_baidu_map.description, pic_uuid: @fw_baidu_map.pic_uuid, title: @fw_baidu_map.title, url: @fw_baidu_map.url }
    end

    assert_redirected_to fw_baidu_map_path(assigns(:fw_baidu_map))
  end

  test "should show fw_baidu_map" do
    get :show, id: @fw_baidu_map
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fw_baidu_map
    assert_response :success
  end

  test "should update fw_baidu_map" do
    put :update, id: @fw_baidu_map, fw_baidu_map: { description: @fw_baidu_map.description, pic_uuid: @fw_baidu_map.pic_uuid, title: @fw_baidu_map.title, url: @fw_baidu_map.url }
    assert_redirected_to fw_baidu_map_path(assigns(:fw_baidu_map))
  end

  test "should destroy fw_baidu_map" do
    assert_difference('Fw::BaiduMap.count', -1) do
      delete :destroy, id: @fw_baidu_map
    end

    assert_redirected_to fw_baidu_maps_path
  end
end
