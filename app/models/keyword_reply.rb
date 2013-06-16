# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :replies_attributes

  has_many :replies, as: :target, dependent: :destroy
  ItemTypesForSelect = [["文本","ReplyText"], ["音频","Audio"], ["图文","News"], ["活动","Event"]]
  ItemTypes = ["ReplyText","News","Audio","Event","Activity","ResponseMessage"]
  ItemTypes.each do |item_type|
    has_many item_type.underscore.pluralize.to_sym, through: :replies, source: "item", source_type: item_type
  end

  has_one :ownership, as: :item, dependent: :destroy
  has_one :user, through: :ownership
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

