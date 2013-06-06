class Reply < ActiveRecord::Base
  attr_accessible :keyword_reply_id, :replying_id, :replying_type

  belongs_to :keyword_reply
  belongs_to :replying, polymorphic: true

  validates_presence_of :replying_id, :replying_type

  def outline_content
    send "#{replying.class.to_s.underscore}_outline_content".to_sym, replying
  rescue => e
    logger.error e.to_s
    "unknown content"
  end

  private
  def news_outline_content(replying)
    "News(id: #{replying.id})\n#{replying.title}"
  end
  def audio_outline_content(replying)
    "Audio(id: #{replying.id})\n#{replying.title}"
  end
  def activity_outline_content(replying)
    "activity..."
  end
  def reply_text_outline_content(replying)
    "Text(id: #{replying.id})\n#{replying.content}"
  end
  def nil_class_outline_content(replying)
    "---replying not found or deleted---"
  end
end
