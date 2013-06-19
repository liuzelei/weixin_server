# encoding: utf-8
module Hd::GgkHistoriesHelper
  def generate_ggk_history(item)
    history = item.ggk_histories.where("prize is not null and used_at is null").where(weixin_user_id: @current_weixin_user.id).first
    if history.present?
      if @request_text_content.to_s.split(",").last == "done"
        history.used_at = DateTime.now
        history.status = "已领取"
      else
      end
    else
      history = item.ggk_histories.new \
        weixin_user_id: @current_weixin_user,
        sn_code: SecureRandom.uuid
      max_random = item.max_random
      max_luck = item.max_luck
      if (max_random.to_i > 1) and (max_luck.to_i > 0) and (Random.rand(max_random.to_i)<max_luck.to_i) and (item.ggk_histories.where("prize is not null").count < max_luck)
        history.prize = "1"
      else
      end
    end

    history.save
    return history
  end
end

