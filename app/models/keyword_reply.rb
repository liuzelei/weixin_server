# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :reply_content, :news_id, :coupon, :news_ids, :replies_attributes

  has_many :replies, dependent: :destroy
  ItemTypes = ["ReplyText","News","Audio","Activity"]
  ItemTypes.each do |item_type|
    has_many item_type.underscore.pluralize.to_sym, through: :replies, source: "item", source_type: item_type
  end

  has_one :ownership, as: :item, dependent: :destroy
  has_one :user, through: :ownerships
  accepts_nested_attributes_for :replies, allow_destroy: true

  before_save :downcase_keyword

  # TODO, 添加某用户下关键词唯一性验证，注意性能
  #validates_uniqueness_of :keyword, case_sensitive: false
  #validates_uniqueness_of :keyword, scope: [], case_sensitive: false

  private
  def downcase_keyword
    self.keyword.try :downcase!
  end
end

