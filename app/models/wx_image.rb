class WxImage < ActiveRecord::Base
  attr_accessible :weixin_user_id, :pic_url, :request_message_id
  belongs_to :weixin_user
  belongs_to :request_message

end

