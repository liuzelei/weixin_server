# encoding: utf-8
class KeywordReply < ActiveRecord::Base
  attr_accessible :keyword, :replies_attributes

  has_many :replies, as: :target, dependent: :destroy
  ItemTypesForSelect = [["文本","ReplyText"], ["音频","Audio"], ["图文","News"], ["刮刮卡","Hd::Ggk"],["大转盘","Hd::Dzp"],["地图","Fw::BaiduMap"]]
  ItemTypes = ["ReplyText","News","Audio","Activity","ResponseMessage"]
  ItemTypes.each do |it|
    has_many it.underscore.pluralize.to_sym, through: :replies, source: "item", source_type: it
  end
  EventTypes = ["Ggk","Dzp"]
  EventTypes.each do |it|
    has_many it.underscore.pluralize.to_sym, through: :replies, source: "item", source_type: "Hd::#{it}"
  end
  ServiceTypes = ["BaiduMap"]
  ServiceTypes.each do |it|
    has_many it.underscore.pluralize.to_sym, through: :replies, source: "item", source_type: "Fw::#{it}"
  end

  has_one :ownership, as: :item, dependent: :destroy
  has_one :user, through: :ownership
  accepts_nested_attributes_for :replies, allow_destroy: true

  before_save :downcase_keyword

  validates_presence_of :keyword
  # TODO, 添加某用户下关键词唯一性验证，注意性能
  #validates_uniqueness_of :keyword, case_sensitive: false
  #validates_uniqueness_of :keyword, scope: [], case_sensitive: false

  private
  def downcase_keyword
    self.keyword.try :downcase!
  end
end

