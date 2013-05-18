class ResponseMessage < ActiveRecord::Base
  attr_accessible :content, :weixin_user_id, :request_message_id

  belongs_to :request_message
  belongs_to :weixin_user

end
