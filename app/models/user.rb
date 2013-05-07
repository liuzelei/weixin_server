class User < ActiveRecord::Base
  attr_accessible :open_id, :weixin_id, :sex, :age, :address

  has_many :wx_texts
  has_many :event

  def gender_name
    case sex
    when true
      "男"
    when false
      "女"
    else
      "未知"
    end
  end

end
