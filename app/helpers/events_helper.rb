module EventsHelper
  def generate_event_activity(item)
    activity = current_user.scratch_cards.new \
      weixin_user_id: @current_weixin_user,
      sn_code: SecureRandom.uuid

    max_random = item.max_random
    max_luck = item.max_luck
    luck = (self.max_random.to_i * 0.6).to_i
    if (max_random.to_i > 1) and (luck == Random.rand(max_random.to_i)) and (activity.class.where("prize is not null").count <= self.max_luck)
      activity.prize = "1"
    else
    end
    
    activity.save
  end
end

