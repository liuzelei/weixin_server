# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :reply_content, :news_id, :coupon, :news_ids, :replies_attributes

  has_many :replies, as: :replying, dependent: :destroy
  has_one :ownership, as: :item, dependent: :destroy
  has_one :user, through: :ownerships
  accepts_nested_attributes_for :replies, allow_destroy: true

  before_save :downcase_keyword

  validates_uniqueness_of :keyword, case_sensitive: false
  #validates_uniqueness_of :keyword, scope: [], case_sensitive: false

  private
  def downcase_keyword
    self.keyword.try :downcase!
  end
end

