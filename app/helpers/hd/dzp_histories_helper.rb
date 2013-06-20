module Hd::DzpHistoriesHelper
  def generate_dzp_history(item)
    history = item.dzp_histories.new \
      weixin_user_id: @current_weixin_user,
      sn_code: SecureRandom.uuid

    history.save
    return history
  end
end
