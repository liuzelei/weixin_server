# encoding: utf-8
class Reply < ActiveRecord::Base
  attr_accessible :keyword_reply_id, :item_id, :item_type

  belongs_to :target, polymorphic: true
  belongs_to :item, polymorphic: true

  validates_presence_of :item_id, :item_type

  def outline_content
    send "#{item.class.to_s.underscore}_outline_content".to_sym, item
  rescue => e
    logger.error e.to_s
    "unknown content"
  end

  private
  def news_outline_content(item)
    "图文(ID: #{item.id})\n#{item.title}"
  end
  def audio_outline_content(item)
    "音频(ID: #{item.id})\n#{item.title}"
  end
  def event_outline_content(item)
    "活动(ID: #{item.id})\n#{item.title}"
  end
  def activity_outline_content(item)
    "活动..."
  end
  def reply_text_outline_content(item)
    "文本(ID: #{item.id})\n#{item.content}"
  end
  def nil_class_outline_content(item)
    "---replying not found or deleted---"
  end
end
