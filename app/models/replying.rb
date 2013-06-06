class Replying < ActiveRecord::Base
  attr_accessible :keyword_reply_id, :reply_id, :reply_type

  belongs_to :keyword_reply
  belongs_to :reply, polymorphic: true

  validates_presence_of :keyword_reply_id, :reply_id, :reply_type

end
