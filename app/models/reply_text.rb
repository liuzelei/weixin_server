class ReplyText < ActiveRecord::Base
  attr_accessible :content

  has_many :replies, as: :replying, dependent: :destroy

  validates_presence_of :content

end
