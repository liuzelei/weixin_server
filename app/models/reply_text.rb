class ReplyText < ActiveRecord::Base
  attr_accessible :content

  has_many :replies, as: :item, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy

  validates_presence_of :content

end
