class ReplyText < ActiveRecord::Base
  attr_accessible :content

  has_many :replies, as: :replying

  validates_presence_of :content

end
