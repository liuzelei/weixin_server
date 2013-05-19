# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :reply_content, :news_id, :coupon


  def specific_content
    if reply_content.present?
      reply_content
    elsif news_id.present?
      news = News.find_by_id(news_id)
      (news.title.to_s + news.items.map(&:title).join(",\n")) if news.present?
    else
      "未知消息"
    end
  end
end

