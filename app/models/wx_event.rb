class WxEvent < ActiveRecord::Base
  attr_accessible :weixin_user_id, :event, :event_key
  belongs_to :weixin_user
  belongs_to :request_message

end

