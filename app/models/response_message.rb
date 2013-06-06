# encoding: utf-8
class ResponseMessage < ActiveRecord::Base
  attr_accessible :content, :weixin_user_id, :request_message_id

  belongs_to :request_message
  belongs_to :weixin_user

  def outline_content
    if content.present?
      content
    elsif news_id.present?
      news = News.find_by_id(news_id)
      (news.title.to_s + news.items.map(&:title).join(",\n")) if news.present?
    else
      "未知消息"
    end
  end
end
