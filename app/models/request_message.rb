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

  def outline_content
    case msg_type
    when "text"
      wx_text.try :content
    when "image"
      wx_image.try :pic_url
    when "location"
      "#{wx_location.try(:latitude)}:#{wx_location.try(:longitude)}"
    when "link"
      "#{wx_link.try(:title)}:#{wx_link.try(:url)}"
    when "event"
      wx_event.try :event
    else
      "未知消息"
    end
  end
end
