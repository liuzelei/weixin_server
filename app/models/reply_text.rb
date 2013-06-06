class ReplyText < ActiveRecord::Base
  attr_accessible :content

  has_many :replyings, as: :reply

  validates_presence_of :content

end
