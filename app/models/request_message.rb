class RequestMessage < ActiveRecord::Base
  attr_accessible :xml, :weixin_user_id, :msg_type

  has_many :wx_texts, :wx_locations, :wx_images, :wx_links, :wx_events
  belongs_to :weixin_user
end
