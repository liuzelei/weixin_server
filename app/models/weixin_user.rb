# encoding: utf-8
class WeixinUser < ActiveRecord::Base

  attr_accessible :open_id, :weixin_id, :sex, :age, :location_x, :location_y, :scale

  has_many :wx_texts
  has_many :wx_locations
  has_many :events
  has_many :coupons

  acts_as_taggable
  acts_as_taggable_on :categories

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

end
