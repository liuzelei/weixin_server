module Hd::GgkHistoriesHelper
  def generate_ggk_history(item)
    history = item.ggk_histories.new \
      weixin_user_id: @current_weixin_user,
      sn_code: SecureRandom.uuid

    max_random = item.max_random
    max_luck = item.max_luck
    luck = (max_random.to_i * 0.6).to_i
    if (max_random.to_i > 1) and (max_luck.to_i > 0) and (Random.rand(max_random.to_i)<max_luck.to_i)# and (current_user.scratch_cards.where("prize is not null").count < max_luck)
      history.prize = "1"
    else
    end
    
    history.save
    return history
  end
end
