class RequestMessage < ActiveRecord::Base
  attr_accessible :xml, :weixin_user_id, :msg_type

  has_one :wx_texts
  has_one :wx_locations
  has_one :wx_images
  has_one :wx_links
  has_one :wx_events

  belongs_to :weixin_user
end
