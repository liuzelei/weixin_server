class RequestMessage < ActiveRecord::Base
  attr_accessible :xml, :weixin_user_id, :msg_type

  has_one :wx_text
  has_one :wx_location
  has_one :wx_image
  has_one :wx_link
  has_one :wx_event
  has_one :response_message

  belongs_to :weixin_user
end
