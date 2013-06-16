require 'test_helper'

class Hd::ScratchCardsControllerTest < ActionController::TestCase
  setup do
    @hd_scratch_card = hd_scratch_cards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hd_scratch_cards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hd_scratch_card" do
    assert_difference('Hd::ScratchCard.count') do
      post :create, hd_scratch_card: { prize: @hd_scratch_card.prize, sn_code: @hd_scratch_card.sn_code, status: @hd_scratch_card.status, used_at: @hd_scratch_card.used_at, weixin_user_id: @hd_scratch_card.weixin_user_id }
    end

    assert_redirected_to hd_scratch_card_path(assigns(:hd_scratch_card))
  end

  test "should show hd_scratch_card" do
    get :show, id: @hd_scratch_card
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hd_scratch_card
    assert_response :success
  end

  test "should update hd_scratch_card" do
    put :update, id: @hd_scratch_card, hd_scratch_card: { prize: @hd_scratch_card.prize, sn_code: @hd_scratch_card.sn_code, status: @hd_scratch_card.status, used_at: @hd_scratch_card.used_at, weixin_user_id: @hd_scratch_card.weixin_user_id }
    assert_redirected_to hd_scratch_card_path(assigns(:hd_scratch_card))
  end

  test "should destroy hd_scratch_card" do
    assert_difference('Hd::ScratchCard.count', -1) do
      delete :destroy, id: @hd_scratch_card
    end

    assert_redirected_to hd_scratch_cards_path
  end
end
