# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :reply_content, :news_id, :coupon, :news_ids, :replyings_attributes

  has_many :replyings
  accepts_nested_attributes_for :replyings, allow_destroy: true

  before_save :downcase_keyword

  validates_uniqueness_of :keyword, case_sensitive: false
  #validates_uniqueness_of :keyword, scope: [], case_sensitive: false

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

  private
  def downcase_keyword
    self.keyword.try :downcase!
  end
end

