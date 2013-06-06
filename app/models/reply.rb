class Reply < ActiveRecord::Base
  attr_accessible :keyword_reply_id, :replying_id, :replying_type

  belongs_to :keyword_reply
  belongs_to :replying, polymorphic: true

  validates_presence_of :replying_id, :replying_type

end
