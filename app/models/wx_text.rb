class WxText < ActiveRecord::Base
  attr_accessible :content, :weixin_user_id, :request_message_id
  belongs_to :weixin_user
  belongs_to :request_message

end

