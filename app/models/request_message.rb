class RequestMessage < ActiveRecord::Base
  attr_accessible :xml, :weixin_user_id, :msg_type

  has_many :wx_texts
  has_many :wx_locations
  has_many :wx_images
  has_many :wx_links
  has_many :wx_events

  belongs_to :weixin_user
end
