class WxLink < ActiveRecord::Base
  attr_accessible :weixin_user_id, :title, :description, :url , :request_message_id
  belongs_to :weixin_user
  belongs_to :request_message

end


