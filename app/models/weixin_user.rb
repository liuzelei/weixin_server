# encoding: utf-8
class WeixinUser < ActiveRecord::Base
  before_validation :repair_tags

  attr_accessible :open_id, :weixin_id, :sex, :age, :latitude, :longitude, :scale, :category_list, :tag_list

  has_many :request_messages
  has_many :wx_texts
  has_many :wx_locations
  has_many :wx_images
  has_many :wx_links
  has_many :wx_events
  has_many :response_messages

  has_many :coupons

  acts_as_taggable
  acts_as_taggable_on :categories

  geocoded_by :geocoding_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address


  def sex_name
    case sex
    when "0", 0, false
      "女"
    when "1", 1, true
      "男"
    else
      "未知"
    end
  end

  def age_range
    case age
    when "0", 0
      "< 20"
    when "1", 1
      "20-30"
    when "2", 2
      "30-40"
    when "3", 3
      "40-50"
    when "4", 4
      "> 50"
    else
      "未知"
    end
  end

  private
  def repair_tags
    #self.category_list = self.category_list.join(",").split_all if self.category_list.present?
    self.tag_list = self.tag_list.join(",").split_all if self.tag_list.present?
  end
end
