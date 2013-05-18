# encoding: utf-8
class RequestMessage < ActiveRecord::Base
  attr_accessible :xml, :weixin_user_id, :msg_type

  has_one :wx_text
  has_one :wx_location
  has_one :wx_image
  has_one :wx_link
  has_one :wx_event
  has_one :response_message

  belongs_to :weixin_user

  def specific_content
    if wx_text
      wx_text.content
    elsif wx_event
      wx_event.event
    elsif wx_image
      wx_image.pic_url
    elsif wx_location
      "#{wx_location.location_x}:#{wx_location.location_y}"
    elsif wx_link
      "#{wx_link.title}:#{wx_link.url}"
    else
      "未知消息"
    end
  end
end
